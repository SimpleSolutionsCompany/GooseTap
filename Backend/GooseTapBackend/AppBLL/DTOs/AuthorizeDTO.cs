using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppBLL.DTOs
{
    public class AuthorizeDTO
    {
       

        public string FirstName { get; set; }
        public string? LastName { get; set; }
        public string? UserName { get; set; }
        public string TelegramId { get; set; }
    }
}
