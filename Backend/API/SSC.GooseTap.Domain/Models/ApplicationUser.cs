using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;


namespace SSC.GooseTap.Domain.Models
{
    /// <summary>
    /// Головна сутність користувача.
    /// Успадковує IdentityUser для інтеграції з ASP.NET Identity.
    /// Містить як дані автентифікації, так і ігровий стан.
    /// </summary>
    public class ApplicationUser : IdentityUser<Guid>
    {
        
        

        /// <summary>
        /// Унікальний Telegram ID користувача.
        /// Це буде наш основний "login" з Telegram.
        /// </summary>
        public string TelegramId { get; set; }

        
       


        

        /// <summary>
        /// Основний баланс монет (остання збережена версія з SQL).
        /// </summary>
        public long Balance { get; set; } = 0;

        /// <summary>
        /// Пасивний дохід на секунду
        /// </summary>
        public long ProfitPerSecond { get; set; } = 0;

        /// <summary>
        /// Остання дата, коли було зараховано пасивний дохід.
        /// </summary>
        
        public DateTime LastPassiveIncomeClaim { get; set; } = DateTime.UtcNow;


        

        /// <summary>
        /// Максимальний запас енергії.
        /// </summary>
        public int MaxEnergy { get; set; } = 1000;

        /// <summary>
        /// Поточна енергія (остання збережена версія з SQL).
        /// </summary>
        public int CurrentEnergy { get; set; } = 1000;

        /// <summary>
        /// Швидкість відновлення енергії (одиниць на секунду).
        /// </summary>
        public int EnergyRestorePerSecond { get; set; } = 1;

        /// <summary>
        /// Час останнього відновлення енергії (для розрахунку оффлайн).
        /// </summary>
        public DateTime LastEnergyRestoreTime { get; set; } = DateTime.UtcNow;

        /// <summary>
        /// Поточний рівень користувача.
        /// </summary>
        public int Level { get; set; } = 1;

        /// <summary>
        /// Ранг користувача (напр. Bronze, Silver).
        /// </summary>
        public string Rank { get; set; } = "Bronze";

        /// <summary>
        /// Скількі кліків приносить користувачу один клік.
        /// </summary>
        public int ProfitPerClick { get; set; } = 1;

        // --- Навігаційні властивості ---

        /// <summary>
        /// Список апгрейдів, які купив цей користувач.
        /// </summary>
        public List<UserUpgrade>? UserUpgrades { get; set; }
    }
}
