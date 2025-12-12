using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSC.GooseTap.Infrastructure.Configuration
{
    public class EmailSettings
    {
        public string SmtpServer { get; set; }
        public int SmtpPort { get; set; }
        public string SenderEmail { get; set; }
        public string SenderDisplayName { get; set; }
        public string SenderPassword { get; set; }
        public bool UseSSL { get; set; }
    }
}
