using System.Diagnostics;
using MailKit.Net.Smtp;
using MimeKit;
using SSC.GooseTap.Business.Contracts.Infrastructure;
using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Infrastructure.Configuration;

namespace SSC.GooseTap.Infrastructure.Services
{
    public class EmailService : IEmailService
    {
        private readonly EmailSettings _emailSettings;

        public EmailService(EmailSettings emailSettings)
        {
            _emailSettings = emailSettings;
        }

        public async Task SendEmailAsync(string email, string subject, string message)
        {
            try
            {
                var emailMessage = new MimeMessage();

                emailMessage.From.Add(new MailboxAddress(_emailSettings.SenderDisplayName, _emailSettings.SenderEmail));
                emailMessage.To.Add(MailboxAddress.Parse(email));
                emailMessage.Subject = subject;

                var builder = new BodyBuilder();
                builder.HtmlBody = message;
                emailMessage.Body = builder.ToMessageBody();

                using (var client = new SmtpClient())
                {

                    client.ServerCertificateValidationCallback = (s, c, h, e) => true;

                    await client.ConnectAsync(_emailSettings.SmtpServer, _emailSettings.SmtpPort, MailKit.Security.SecureSocketOptions.StartTls);


                    if (!string.IsNullOrEmpty(_emailSettings.SenderPassword))
                    {
                        await client.AuthenticateAsync(_emailSettings.SenderEmail, _emailSettings.SenderPassword);
                    }

                    await client.SendAsync(emailMessage);
                    await client.DisconnectAsync(true);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
        }
    }
}
