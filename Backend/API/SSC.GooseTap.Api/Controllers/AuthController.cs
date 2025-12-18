using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

using SSC.GooseTap.Business.DTOs;
using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Infrastructure.Services;
using SSC.GooseTap.Infrastructure.Services.JwtToken;
using SSC.GooseTap.Infrastructure.Services.TelegramAuth;

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
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            string currentEnv = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Production";
            bool isDevelopment = currentEnv == "Development";

            // Logic:
            // 1. If Dev AND No InitData (or empty) -> Test User Login
            // 2. Else -> Real Telegram Auth (Validate -> Parse -> Use/Create)
            
            if (isDevelopment )
            {
                logger.LogInformation("Development mode & No InitData: Using Test User.");
                
                string testTgId = "12345678";
                var testUser = await userManager.Users.FirstOrDefaultAsync(u => u.TelegramId == testTgId);

                if (testUser == null)
                {
                    logger.LogInformation("Test user not found, creating new one.");
                    testUser = new ApplicationUser
                    {
                        Id = Guid.Parse("7bae70d1-2a95-4be5-9d19-0a1b59a4ccac"), // Fixed ID for consistency
                        UserName = "test_username",
                        Email = "test@mail.com",
                        TelegramId = testTgId,
                        EmailConfirmed = true,
                        Balance = 0,
                        Level = 1,
                        ProfitPerClick = 1,
                        MaxEnergy = 1000,
                        CurrentEnergy = 1000,
                        EnergyRestorePerSecond = 1,
                        LastEnergyRestoreTime = DateTime.UtcNow
                    };
                    
                    var result = await userManager.CreateAsync(testUser);
                    if (!result.Succeeded)
                    {
                         // Handle potential ID conflict if DB has different user with same ID?
                         // Or just try without ID.
                         logger.LogError("Failed to create test user: {Errors}", string.Join(", ", result.Errors.Select(e => e.Description)));
                         return BadRequest(new { Message = "Could not create test user." });
                    }
                }
                
                return await GenerateAuthResponse(testUser, false);
            }
            else
            {
                 // --- Real Telegram Auth Logic ---
                 // If specifically requesting Real Auth but no data provided (e.g. in Prod), fail.
                 if (string.IsNullOrEmpty(dto.InitDataRaw))
                 {
                     return BadRequest(new { Message = "InitDataRaw is required in Production or when testing real auth." });
                 }

                 // 1. Валідація хешу (Validate hash)
                 // (Також варто додати перевірку auth_date, як ми обговорювали)
                 if (!_telegramAuthService.Validate(dto.InitDataRaw))
                 {
                     logger.LogWarning("Telegram Auth Failed: Invalid hash.");
                     return Unauthorized(new { Message = "Invalid data signature." });
                 }

                 // 2. Отримання даних користувача (Get User Data)
                 var telegramUser = _telegramAuthService.GetUser(dto.InitDataRaw);
                 if (telegramUser == null || string.IsNullOrEmpty(telegramUser.Id.ToString()))
                 {
                     logger.LogWarning("Telegram Auth Failed: Could not parse user data.");
                     return BadRequest(new { Message = "Could not parse user data." });
                 }

                 string telegramId = telegramUser.Id.ToString();

                 // 3. Пошук або Реєстрація (Find or Create)
                 var user = await userManager.Users.FirstOrDefaultAsync(u => u.TelegramId == telegramId);
                 bool isNew = false;

                 if (user == null)
                 {
                     isNew = true;
                     logger.LogInformation("Creating new user for Telegram ID {TelegramId}", telegramId);

                     var username = telegramUser.Username ?? $"tg_{telegramId}";
                     var email = $"tg_{telegramId}@telegram.dummy";

                     var newUser = new ApplicationUser
                     {
                         UserName = username,
                         Email = email,
                         TelegramId = telegramId,
                         EmailConfirmed = true,
                         // Initial Game State Defaults
                         Balance = 0,
                         Level = 1,
                         ProfitPerClick = 1,
                         MaxEnergy = 1000,
                         CurrentEnergy = 1000,
                         EnergyRestorePerSecond = 1,
                         LastEnergyRestoreTime = DateTime.UtcNow
                     };

                     var createResult = await userManager.CreateAsync(newUser);
                     if (!createResult.Succeeded)
                     {
                         logger.LogError("Failed to create user: {Errors}", string.Join(", ", createResult.Errors.Select(e => e.Description)));
                         return BadRequest(new { Message = "Could not create user." });
                     }

                     await userManager.AddLoginAsync(newUser, new UserLoginInfo("Telegram", telegramId, "Telegram"));
                     user = newUser;
                 }

                 logger.LogInformation("Generating tokens for user {UserId}", user.Id);
                 return await GenerateAuthResponse(user, isNew);
            }
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] TelegramValidateRequest dto)
        {
            // For compatibility with frontend preference of /api/auth/login
            return await LoginTelegram(dto);
        }


        private Task<IActionResult> GenerateAuthResponse(ApplicationUser user, bool isNewUser = false)
        {
            var token = tokenService.CreateToken(user);

            return Task.FromResult<IActionResult>(Ok(new TelegramValidateResponse()
            {
                AccessToken = token,
                ExpiresAt = DateTime.Now.AddMinutes(20),
                IsNewUser = isNewUser,
            }));
        }
    }
}
