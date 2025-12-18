using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.DTOs
{
    public class SyncGameRequestDto
    {
        public int ClickCount { get; set; }
    }

    public class UpgradeDto
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public BoosterType BoosterType { get; set; }
        
        public int CurrentLevel { get; set; }
        public int MaxLevel { get; set; }
        public long Price { get; set; }
        public int EffectValue { get; set; }
        public double CostMultiplier { get; set; }
        
        // Tells the UI if user can afford it or if matched max level
        public bool CanBuy { get; set; }
    }

    public class ClickResponseDto
    {
        public long Balance { get; set; }
        public int CurrentEnergy { get; set; }
        public int ProfitPerClick { get; set; }
        public int EnergyRestorePerSecond { get; set; }
    }

    public class BuyUpgradeResponseDto
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public long NewBalance { get; set; }
        public int NewLevel { get; set; }
        public long NextLevelPrice { get; set; }
        public int EffectValue { get; set; }
    }
}
