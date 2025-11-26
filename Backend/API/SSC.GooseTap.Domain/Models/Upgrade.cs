using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSC.GooseTap.Domain.Models
{
    /// <summary>
    /// Описує один тип апгрейду, доступний для покупки в грі.
    /// Це "статичні" дані гри.
    /// </summary>
    public class Upgrade
    {
        /// <summary>
        /// Унікальний текстовий ID (напр., "passive_income_hamster_1")
        /// </summary>
        public string Id { get; set; }

        public string Name { get; set; }
        public string Description { get; set; }

        /// <summary>
        /// Базова вартість покупки (для 1-го рівня).
        /// </summary>
        public long BaseCost { get; set; }

        /// <summary>
        /// Базовий дохід, який дає цей апгрейд на 1-му рівні.
        /// </summary>
        public long BaseProfitPerHour { get; set; }

        // TODO: Можна додати коефіцієнт зростання вартості (CostMultiplier)

        // --- Навігаційні властивості ---

        /// <summary>
        /// Зв'язок з користувачами, які купили цей апгрейд.
        /// </summary>
        public virtual ICollection<UserUpgrade> UserUpgrades { get; set; } = new List<UserUpgrade>();
    }
}
