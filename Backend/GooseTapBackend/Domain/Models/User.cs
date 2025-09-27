using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Models
{
    public class User
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "TelegramId is can't be null")]
        public string TelegramId {  get; set; }




        [Required]
        public string FirstName { get; set; }
        public string? LastName { get; set; }
        public string? UserName { get; set; }
    }
}
