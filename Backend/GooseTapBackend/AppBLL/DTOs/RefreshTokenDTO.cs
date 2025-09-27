using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppBLL.DTOs
{
    public class RefreshTokenDTO
    {
        [Required]
        public string RefreshToken { get; set; }

        [Required]
        public string Token { get; set; }
    }
}
