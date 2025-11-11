using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Models
{
    /// <summary>
    /// Join Table (Таблиця зв'язку) між ApplicationUser та Upgrade.
    /// Показує, який апгрейд якого рівня має користувач.
    /// </summary>
    public class UserUpgrade
    {
        public string ApplicationUserId { get; set; }
        public virtual ApplicationUser ApplicationUser { get; set; }

        public string UpgradeId { get; set; }
        public virtual Upgrade Upgrade { get; set; }

        /// <summary>
        /// Поточний рівень цього апгрейду у цього користувача.
        /// </summary>
        public int Level { get; set; }
    }
}
