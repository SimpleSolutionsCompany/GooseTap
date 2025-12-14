using System;

namespace SSC.GooseTap.Business.Responces
{
    public class BuyUpgradeResponse
    {
        public bool Success { get; set; }
        public long NewBalance { get; set; }
        public decimal NewProfitPerHour { get; set; }
        public long NextLevelPrice { get; set; }
    }
}
