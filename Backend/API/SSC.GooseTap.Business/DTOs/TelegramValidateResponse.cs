using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSC.GooseTap.Business.DTOs
{
    public class TelegramValidateResponse
    {
        [System.Text.Json.Serialization.JsonPropertyName("accessToken")]
        public string AccessToken { get; set; } = string.Empty;
        // No refresh token
        public DateTime ExpiresAt { get; set; }
        
       
        public bool IsNewUser { get; set; }
    }   
}
