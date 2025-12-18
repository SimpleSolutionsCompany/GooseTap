using SSC.GooseTap.Business.DTOs;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SSC.GooseTap.Business.Services
{
    public class GameService(IUnitOfWork unitOfWork) : IGameService
    {
        public async Task<Result<ClickResponseDto>> SyncAsync(Guid userId, SyncGameRequestDto? request)
        {
            var user = await unitOfWork.Users.GetByIdAsync(userId);
            if (user == null) return Result.Fail<ClickResponseDto>("User not found");

            SyncEnergy(user);

            if (request != null && request.ClickCount > 0)
            {
                int clicks = request.ClickCount;
                int energyCost = 1; // Assuming 1 energy per click for now
                int totalEnergyCost = clicks * energyCost;

                // For batched sync, we cap the clicks by available energy to prevent negative energy
                if (user.CurrentEnergy < totalEnergyCost)
                {
                    clicks = user.CurrentEnergy / energyCost;
                    totalEnergyCost = clicks * energyCost;
                }

                if (clicks > 0)
                {
                    user.CurrentEnergy -= totalEnergyCost;
                    user.Balance += (long)clicks * user.ProfitPerClick;
                }
            }

            await unitOfWork.SaveChangesAsync();

            return Result.Ok(new ClickResponseDto
            {
                Balance = user.Balance,
                CurrentEnergy = user.CurrentEnergy,
                ProfitPerClick = user.ProfitPerClick,
                EnergyRestorePerSecond = user.EnergyRestorePerSecond
            });
        }

        public async Task<Result<IEnumerable<UpgradeDto>>> GetUpgradesAsync(Guid userId)
        {
             // Use the new method to get user with upgrades
            var user = await unitOfWork.Users.GetByIdWithUpgradesAsync(userId);
            if (user == null) return Result.Fail<IEnumerable<UpgradeDto>>("User not found");

            var allUpgrades = await unitOfWork.Upgrades.GetAllAsync();
            
            var result = new List<UpgradeDto>();

            foreach (var upgrade in allUpgrades)
            {
                // Find if user has bought this upgrade
                var userUpgrade = user.UserUpgrades?.FirstOrDefault(u => u.UpgradeId == upgrade.Id);
                int currentLevel = userUpgrade?.Level ?? 0;
                
                // Calculate Price for NEXT level (currentLevel + 1)
                // If max level reached, we can show max level price or disable buy.
                long price = CalculatePrice(upgrade.BaseCost, upgrade.CostMultiplier, currentLevel);
                
                bool canBuy = currentLevel < upgrade.MaxLevel && user.Balance >= price;

                result.Add(new UpgradeDto
                {
                    Id = upgrade.Id,
                    Name = upgrade.Name,
                    Description = upgrade.Description,
                    BoosterType = upgrade.BoosterType,
                    CurrentLevel = currentLevel,
                    MaxLevel = upgrade.MaxLevel,
                    Price = price,
                    EffectValue = upgrade.EffectValue,
                    CostMultiplier = upgrade.CostMultiplier,
                    CanBuy = canBuy
                });
            }

            return Result.Ok<IEnumerable<UpgradeDto>>(result);
        }

        public async Task<Result<BuyUpgradeResponseDto>> BuyUpgradeAsync(Guid userId, Guid upgradeId)
        {
            var user = await unitOfWork.Users.GetByIdWithUpgradesAsync(userId);
            if (user == null) return Result.Fail<BuyUpgradeResponseDto>("User not found");

            var upgrade = await unitOfWork.Upgrades.GetByIdAsync(upgradeId);
            if (upgrade == null) return Result.Fail<BuyUpgradeResponseDto>("Upgrade not found");

            // Check current level
            var userUpgrade = user.UserUpgrades?.FirstOrDefault(u => u.UpgradeId == upgradeId);
            int currentLevel = userUpgrade?.Level ?? 0;

            if (currentLevel >= upgrade.MaxLevel)
            {
                return Result.Fail<BuyUpgradeResponseDto>("Maximum level reached.");
            }

            // Calculate Price
            long price = CalculatePrice(upgrade.BaseCost, upgrade.CostMultiplier, currentLevel);
            
            if (user.Balance < price)
            {
                return Result.Fail<BuyUpgradeResponseDto>("Not enough coins.");
            }

            // Deduct Coins
            user.Balance -= price;

            // Apply Upgrade
            int newLevel = currentLevel + 1;
            
            if (userUpgrade == null)
            {
                // Create new link
                userUpgrade = new UserUpgrade
                {
                    ApplicationUserId = user.Id,
                    UpgradeId = upgrade.Id,
                    Level = newLevel
                };
                // Ensure list exists
                if (user.UserUpgrades == null) user.UserUpgrades = new List<UserUpgrade>();
                user.UserUpgrades.Add(userUpgrade);
            }
            else
            {
                userUpgrade.Level = newLevel;
            }

            // Apply Effect based on Type
            ApplyUpgradeEffect(user, upgrade.BoosterType, upgrade.EffectValue);

            await unitOfWork.SaveChangesAsync();
            
            long nextPrice = CalculatePrice(upgrade.BaseCost, upgrade.CostMultiplier, newLevel);

            return Result.Ok(new BuyUpgradeResponseDto
            {
                Success = true,
                Message = "Upgrade purchased successfully.",
                NewBalance = user.Balance,
                NewLevel = newLevel,
                NextLevelPrice = nextPrice,
                EffectValue = upgrade.EffectValue
            });
        }
        
        private void ApplyUpgradeEffect(ApplicationUser user, BoosterType type, int effectValue)
        {
            switch (type)
            {
                case BoosterType.Multitap:
                    user.ProfitPerClick += effectValue;
                    break;
                case BoosterType.EnergyLimit:
                    user.MaxEnergy += effectValue;
                    break;
                case BoosterType.RestoreEnergyPerSecond:
                    user.EnergyRestorePerSecond += effectValue;
                    break;
            }
        }
        
        private void SyncEnergy(ApplicationUser user)
        {
            var now = DateTime.UtcNow;
            var secondsPassed = (now - user.LastEnergyRestoreTime).TotalSeconds;
            if (secondsPassed < 1) return;

            int restored = (int)(secondsPassed * user.EnergyRestorePerSecond);
            if (restored > 0)
            {
                // If we are over cap, don't reduce, just don't add.
                if (user.CurrentEnergy < user.MaxEnergy)
                {
                    user.CurrentEnergy = Math.Min(user.MaxEnergy, user.CurrentEnergy + restored);
                }
                user.LastEnergyRestoreTime = now;
            }
        }
        
        private long CalculatePrice(long baseCost, double multiplier, int level)
        {
            // Level 1 costs BaseCost. Level 2 costs BaseCost * Multiplier^1.
            // Formula: Price = BaseCost * (Multiplier ^ CurrentLevel)
            return (long)(baseCost * Math.Pow(multiplier, level));
        }
    }
}
