using System;

namespace SSC.GooseTap.Business.Responces
{
    public class CheckpointResponse
    {
        public long Balance { get; set; }
        public int Energy { get; set; }
        public int MaxEnergy { get; set; }
        public decimal ProfitPerHour { get; set; }
        public decimal OfflineIncome { get; set; }
        public DateTime LastSyncDate { get; set; }

        public int Level { get; set; }
        public string Rank { get; set; } = string.Empty;

        // Boosters info
        public int MultitapLevel { get; set; }
        public int EnergyLimitLevel { get; set; }
        public int RechargeSpeedLevel { get; set; }

        public int ProfitPerClick { get; set; }
        public int EnergyRestorePerSecond { get; set; }
    }
}
