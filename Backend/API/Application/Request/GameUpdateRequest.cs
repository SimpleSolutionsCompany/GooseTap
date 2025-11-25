using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Request
{
    public class GameUpdateRequest
    {
        public int Clicks { get; set; }
        public int EnergySpent { get; set; }
        public DateTime Timestump { get; set; }
    }
}
