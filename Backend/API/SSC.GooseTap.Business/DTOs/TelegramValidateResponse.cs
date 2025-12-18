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
        
        [System.Text.Json.Serialization.JsonPropertyName("expiresAt")]
        public DateTime ExpiresAt { get; set; }
        
        
        [System.Text.Json.Serialization.JsonPropertyName("isNewUser")]
        public bool IsNewUser { get; set; }
    }   
}
