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
    }
}
