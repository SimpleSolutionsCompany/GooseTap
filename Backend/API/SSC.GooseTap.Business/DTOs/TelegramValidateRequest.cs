using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSC.GooseTap.Business.DTOs
{
    public class TelegramValidateRequest
    {
        [System.Text.Json.Serialization.JsonPropertyName("initData")]
        public string InitDataRaw { get; set; }
    }
}
