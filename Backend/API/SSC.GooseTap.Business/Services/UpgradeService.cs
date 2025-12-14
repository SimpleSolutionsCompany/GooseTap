using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Services
{
    public class UpgradeService(IUnitOfWork unitOfWork) : IUpgradeService
    {
        public async Task<Guid> CreateUpgradeAsync(Upgrade upgrade)
        {
            await unitOfWork.UpgradeRepository.AddAsync(upgrade);
            await unitOfWork.SaveChangesAsync();
            return upgrade.Id;
        }

        public async Task<IEnumerable<Upgrade>> GetAllUpgradesAsync()
        {
            return await unitOfWork.UpgradeRepository.GetAllAsync();
        }

        public async Task<Upgrade?> GetUpgradeByIdAsync(Guid id)
        {
            return await unitOfWork.UpgradeRepository.GetByIdAsync(id);
        }

        public async Task UpdateUpgradeAsync(Upgrade upgrade)
        {
             await unitOfWork.UpgradeRepository.UpdateAsync(upgrade);
             await unitOfWork.SaveChangesAsync();
        }

        public async Task DeleteUpgradeAsync(Guid id)
        {
            var upgrade = await unitOfWork.UpgradeRepository.GetByIdAsync(id);
            if (upgrade != null)
            {
                await unitOfWork.UpgradeRepository.DeleteAsync(upgrade);
                await unitOfWork.SaveChangesAsync();
            }
        }

        public async Task<Responces.ApiResponse<Responces.BuyUpgradeResponse>> BuyUpgradeAsync(Guid userId, Guid upgradeId)
        {
            var user = await unitOfWork.UserRepository.GetByIdAsync(userId);
            if (user == null)
            {
                return new Responces.ApiResponse<Responces.BuyUpgradeResponse>("User not found") { Success = false };
            }

            var upgrade = await unitOfWork.UpgradeRepository.GetByIdAsync(upgradeId);
            if (upgrade == null)
            {
                return new Responces.ApiResponse<Responces.BuyUpgradeResponse>("Upgrade not found") { Success = false };
            }

            var userUpgrade = user.UserUpgrades?.FirstOrDefault(u => u.UpgradeId == upgradeId);
            var currentLevel = userUpgrade?.Level ?? 0;
            var nextLevelPrice = upgrade.BaseCost * (currentLevel + 1);

            if (user.Balance < nextLevelPrice)
            {
                return new Responces.ApiResponse<Responces.BuyUpgradeResponse>("Insufficient funds") { Success = false };
            }

            // Deduct cost
            user.Balance -= nextLevelPrice;

            // Increase upgrade level
            if (userUpgrade == null)
            {
                userUpgrade = new UserUpgrade
                {
                    ApplicationUserId = user.Id,
                    UpgradeId = upgrade.Id,
                    Level = 1
                };

                user.UserUpgrades ??= new List<UserUpgrade>();
                user.UserUpgrades.Add(userUpgrade);
            }
            else
            {
                userUpgrade.Level += 1;
            }

            // Increase user's passive income
            // For simplicity, each level adds base profit per hour
            var addedProfitPerHour = upgrade.BaseProfitPerHour;
            user.ProfitPerSecond += (long)Math.Floor(addedProfitPerHour / 3600m);

            await unitOfWork.SaveChangesAsync();

            var response = new Responces.BuyUpgradeResponse
            {
                Success = true,
                NewBalance = user.Balance,
                NewProfitPerHour = user.ProfitPerSecond * 3600m,
                NextLevelPrice = upgrade.BaseCost * (userUpgrade.Level + 1)
            };

            return new Responces.ApiResponse<Responces.BuyUpgradeResponse>(response, "Purchase successful");
        }
    }
}
