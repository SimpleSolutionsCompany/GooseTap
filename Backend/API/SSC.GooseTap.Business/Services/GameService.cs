using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Business.Requests;
using SSC.GooseTap.Business.Responces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Services
{
    public class GameService(IClickQueue clickQueue, IUserService userService)
    {
        private readonly IClickQueue _clickQueue = clickQueue;
        private readonly IUserService _userService = userService;

        public async Task<ApiResponse<string>> ProcessClickAsync(Guid userId, GameUpdateRequest request)
        {
            // 1. Basic Validation (Sync)
            var user = await _userService.GetUserByIdAsync(userId);
            if (user == null)
            {
                return new ApiResponse<string>("User not found") { Success = false };
            }

            // 2. Queue the work
            // We moved the heavy DB update logic to background
            await _clickQueue.QueueBackgroundWorkItemAsync(userId, request);

            return new ApiResponse<string>("Click queued successfully", "Success");
        }

        public async Task<ApiResponse<Responces.CheckpointResponse>> SyncAsync(Guid userId, Requests.SyncRequest request)
        {
            var user = await _userService.GetUserByIdAsync(userId);
            if (user == null)
            {
                return new ApiResponse<Responces.CheckpointResponse>("User not found") { Success = false };
            }

            var now = DateTime.UtcNow;

            // 1. Apply passive income since last claim
            var secondsSinceLastClaim = (now - user.LastPassiveIncomeClaim).TotalSeconds;
            if (secondsSinceLastClaim < 0) secondsSinceLastClaim = 0;

            var offlineIncomeDecimal = user.ProfitPerSecond * (decimal)secondsSinceLastClaim;
            var offlineIncome = (long)Math.Floor(offlineIncomeDecimal);

            user.Balance += offlineIncome;
            user.LastPassiveIncomeClaim = now;

            // 2. Restore energy based on time since last restore
            var secondsSinceEnergyRestore = (now - user.LastEnergyRestoreTime).TotalSeconds;
            if (secondsSinceEnergyRestore < 0) secondsSinceEnergyRestore = 0;

            var energyToRestore = (int)Math.Floor(secondsSinceEnergyRestore * user.EnergyRestorePerSecond);
            if (energyToRestore > 0)
            {
                user.CurrentEnergy = Math.Min(user.MaxEnergy, user.CurrentEnergy + energyToRestore);
                user.LastEnergyRestoreTime = now;
            }

            // 3. Apply taps (consumes energy)
            var taps = Math.Max(0, request?.TapsCount ?? 0);
            var energyAvailable = user.CurrentEnergy;
            var energyUsed = Math.Min(energyAvailable, taps);

            var effectiveTaps = energyUsed; // each tap consumes one energy and yields profit
            var coinsFromTaps = (long)effectiveTaps * user.ProfitPerClick;

            user.Balance += coinsFromTaps;
            user.CurrentEnergy -= energyUsed;

            // 4. Build response
            var response = new Responces.CheckpointResponse
            {
                Balance = user.Balance,
                Energy = user.CurrentEnergy,
                MaxEnergy = user.MaxEnergy,
                ProfitPerHour = Math.Round(user.ProfitPerSecond * 3600m, 2),
                OfflineIncome = offlineIncome,
                LastSyncDate = now,
                Level = user.Level,
                Rank = user.Rank,
                
                // Booster info
                MultitapLevel = user.MultitapLevel,
                EnergyLimitLevel = user.EnergyLimitLevel,
                RechargeSpeedLevel = user.RechargeSpeedLevel,
                ProfitPerClick = user.ProfitPerClick,
                EnergyRestorePerSecond = user.EnergyRestorePerSecond
            };

            await _userService.UpdateUserAsync(user);

            return new ApiResponse<Responces.CheckpointResponse>(response, "Synced");
        }

        public async Task<ApiResponse<string>> BuyBoosterAsync(Guid userId, Requests.BuyBoosterRequest request)
        {
            var user = await _userService.GetUserByIdAsync(userId);
            if (user == null)
            {
                return new ApiResponse<string>("User not found") { Success = false };
            }

            // Define base costs (can be moved to config later)
            const int MultitapBaseCost = 500;
            const int EnergyLimitBaseCost = 500;
            const int RechargeSpeedBaseCost = 2000;

            long cost = 0;
            int currentLevel = 0;

            switch (request.Type)
            {
                case Domain.Models.BoosterType.Multitap:
                    currentLevel = user.MultitapLevel;
                    cost = MultitapBaseCost * (long)Math.Pow(2, currentLevel - 1);
                    break;
                case Domain.Models.BoosterType.EnergyLimit:
                    currentLevel = user.EnergyLimitLevel;
                    // Example: 500, 1000, 2000, etc.
                    cost = EnergyLimitBaseCost * (long)Math.Pow(2, currentLevel - 1);
                    break;
                case Domain.Models.BoosterType.RechargingSpeed:
                    currentLevel = user.RechargeSpeedLevel;
                    cost = RechargeSpeedBaseCost * (long)Math.Pow(2, currentLevel - 1);
                    break;
                default:
                    return new ApiResponse<string>("Invalid booster type") { Success = false };
            }

            if (user.Balance < cost)
            {
                return new ApiResponse<string>("Insufficient funds") { Success = false };
            }

            // Deduct funds
            user.Balance -= cost;

            // Apply effect
            switch (request.Type)
            {
                case Domain.Models.BoosterType.Multitap:
                    user.MultitapLevel++;
                    user.ProfitPerClick += 1;
                    break;
                case Domain.Models.BoosterType.EnergyLimit:
                    user.EnergyLimitLevel++;
                    user.MaxEnergy += 500;
                    user.CurrentEnergy = user.MaxEnergy; // Optional: fill energy on upgrade? Let's just raise max.
                    break;
                case Domain.Models.BoosterType.RechargingSpeed:
                    user.RechargeSpeedLevel++;
                    user.EnergyRestorePerSecond += 1;
                    break;
            }

            await _userService.UpdateUserAsync(user);

            return new ApiResponse<string>("Booster purchased successfully", "Success");
        }
    }
}
