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
        public Guid Id { get; set; }
        
        /// <summary>
        ///  Назва апгрейду.
        /// </summary>

        public string Name { get; set; }
        /// <summary>
        ///  Опис апгрейду.
        ///  </summary>
        public string Description { get; set; }

        /// <summary>
        /// Базова вартість покупки (для 1-го рівня).
        /// </summary>
        public long BaseCost { get; set; }

        public BoosterType BoosterType { get; set; }

        /// <summary>
        /// Множник ціни. Ціна наступного левела = BaseCost * (CostMultiplier ^ Level).
        /// </summary>
        public double CostMultiplier { get; set; } = 2.0;

        /// <summary>
        /// Значення ефекту за один рівень (напр. +1 до кліку, +500 до енергії).
        /// </summary>
        public int EffectValue { get; set; } = 1;

        /// <summary>
        /// Максимальний рівень прокачки.
        /// </summary>
        public int MaxLevel { get; set; } = 10;

        // --- Навігаційні властивості ---

        /// <summary>
        /// Зв'язок з користувачами, які купили цей апгрейд.
        /// </summary>
        public virtual ICollection<UserUpgrade> UserUpgrades { get; set; } = new List<UserUpgrade>();
    }
}
