using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Models
{
    public class UserUpgrade
    {
        public int Id { get; set; }





        public int UserId { get; set; }
        public User UserDetails { get; set; }




        public int UpgradeId { get; set; }
        public Upgrade UpgradeDetails { get; set; }




        public int Level { get; set; }
       
       
        
    }
}
