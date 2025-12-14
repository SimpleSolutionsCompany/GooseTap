
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.Business.Contracts.Infrastructure;
using SSC.GooseTap.Business.DTOs;
using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Infrastructure.Services;

namespace SSC.GooseTap.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [AllowAnonymous]
    public class AuthController(
        UserManager<ApplicationUser> userManager,
        SignInManager<ApplicationUser> signInManager,
        IJwtTokenService tokenService,
        ILogger<AuthController> logger,
        TelegramAuthService telegramAuthService)
        : ControllerBase
    {
        private readonly SignInManager<ApplicationUser> _signInManager = signInManager;

        private readonly TelegramAuthService _telegramAuthService = telegramAuthService;


        [HttpPost("login-telegram")]
        public async Task<IActionResult> LoginTelegram([FromBody] TelegramValidateRequest dto)
        {
            bool IsUserNew = false;


            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            // --- 1. Валідація хешу ---
            // (Також варто додати перевірку auth_date, як ми обговорювали)
            if (!_telegramAuthService.Validate(dto.InitDataRaw))
            {
                logger.LogWarning("Telegram Auth Failed: Invalid hash.");
                return Unauthorized(new { Message = "Invalid data signature." });
            }

            // --- 2. Отримання даних користувача ---
            var telegramUser = _telegramAuthService.GetUser(dto.InitDataRaw);
            if (telegramUser == null || string.IsNullOrEmpty(telegramUser.Id.ToString()))
            {
                logger.LogWarning("Telegram Auth Failed: Could not parse user data.");
                return BadRequest(new { Message = "Could not parse user data." });
            }

            Console.WriteLine("=== Telegram User Data ===");
            Console.WriteLine($"ID: {telegramUser.Id}");
            Console.WriteLine($"First Name: {telegramUser.FirstName}");
            Console.WriteLine($"Last Name: {telegramUser.LastName ?? "N/A"}");
            Console.WriteLine($"Username: {telegramUser.Username ?? "N/A"}");
            Console.WriteLine($"Photo URL: {telegramUser.PhotoUrl ?? "N/A"}");
            Console.WriteLine($"Language Code: {telegramUser.LanguageCode ?? "N/A"}");
            Console.WriteLine($"Allows Write to PM: {telegramUser.AllowsWriteToPm}");
            Console.WriteLine("==========================");



            string telegramId = telegramUser.Id.ToString();

            // --- 3. Пошук або Реєстрація користувача ---
            // Ми шукаємо юзера за його Telegram ID
            var user = await userManager.Users.FirstOrDefaultAsync(u => u.TelegramId == telegramId);

            if (user == null)
            {
                IsUserNew = true;
                
                // Сценарій: РЕЄСТРАЦІЯ
                // Користувача не знайдено, створюємо нового
                logger.LogInformation("Creating new user for Telegram ID {TelegramId}", telegramId);

                // Створюємо унікальний UserName, бо в Telegram він може бути відсутній
                var username = telegramUser.Username ?? $"tg_{telegramId}";

                // Створюємо dummy-email, бо Identity його вимагає
                var email = $"tg_{telegramId}@telegram.dummy";

                var newUser = new ApplicationUser
                {
                    UserName = username,
                    Email = email,
                    


                    TelegramId = telegramId,
                    EmailConfirmed = true
                };

                var createResult = await userManager.CreateAsync(newUser);
                if (!createResult.Succeeded)
                {
                    logger.LogError("Failed to create user: {Errors}", string.Join(", ", createResult.Errors.Select(e => e.Description)));
                    return BadRequest(new { Message = "Could not create user." });
                }

                // Одразу додаємо йому зовнішній логін
                var loginInfo = new UserLoginInfo("Telegram", telegramId, "Telegram");
                await userManager.AddLoginAsync(newUser, loginInfo);

                user = newUser;
            }

            // --- 4. Генерація токенів ---
            // Сценарій: ЛОГІН (або щойно створений юзер)
            logger.LogInformation("Generating tokens for user {UserId}", user.Id);
            return GenerateAuthResponse(user, IsUserNew);
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] TelegramValidateRequest dto)
        {
            // For compatibility with frontend preference of /api/auth/login
            return await LoginTelegram(dto);
        }


        private IActionResult GenerateAuthResponse(ApplicationUser user, bool isNewUser = false)
        {
           
            


            var token = tokenService.CreateToken(user);


            
            return Ok(new TelegramValidateResponse()
            {
                AccessToken = token,
                
                ExpiresAt = DateTime.Now.AddMinutes(20),
                IsNewUser = isNewUser,

            });
        }


    }
}
