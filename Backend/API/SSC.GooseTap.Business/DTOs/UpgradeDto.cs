using System;

namespace SSC.GooseTap.Business.DTOs
{
    public class UpgradeDto
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public long BaseCost { get; set; }
        public long BaseProfitPerHour { get; set; }
        public int UserLevel { get; set; }
        public bool IsAvailable { get; set; }
        public long NextLevelPrice { get; set; }
    }
}
