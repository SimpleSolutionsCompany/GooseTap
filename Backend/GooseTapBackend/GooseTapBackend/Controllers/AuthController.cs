using AppBLL.DTOs;
using Infrastructure.Identity;
using Infrastructure.Services.EmailService.Interfaces;
using Infrastructure.Services.JwtTokenService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Org.BouncyCastle.Crypto;
using System.Security.Claims;

namespace GooseTapBackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly TokenService _tokenService;
        //private readonly IEmailService _emailService;
        //private readonly IMapper _mapper;

        public AuthController(
            UserManager<ApplicationUser> userManager,
            SignInManager<ApplicationUser> signInManager,
            TokenService tokenService,
            IEmailService emailService/*,*/
            //IMapper mapper

            )
        {
            //_emailService = emailService;
            _userManager = userManager;
            _signInManager = signInManager;
            _tokenService = tokenService;
            //_mapper = mapper;
        }



        [HttpPost("authorize")]
        public async Task<ActionResult> Authorize([FromBody] AuthorizeDTO user)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                // Check if user already exists by TelegramId
                var existingUser = await _userManager.Users
                    .FirstOrDefaultAsync(u => u.TelegramId == user.TelegramId);

                ApplicationUser appUser;

                if (existingUser == null)
                {
                    // Auto-register new user
                    appUser = new ApplicationUser
                    {
                        UserName = user.TelegramId, // Use TelegramId as fallback
                        Email = $"{user.TelegramId}@telegram.local", // Dummy email for Telegram users
                        FirstName = user.FirstName,
                        LastName = user.LastName,
                        TelegramId = user.TelegramId,
                        EmailConfirmed = true // Auto-confirm for Telegram users
                    };

                    // Create user without password (Telegram authentication)
                    var result = await _userManager.CreateAsync(appUser);
                    if (!result.Succeeded)
                    {
                        return BadRequest(new { Message = "Failed to create user", Errors = result.Errors });
                    }
                }
                else
                {
                    // Update existing user info if needed
                    appUser = existingUser;
                    bool needsUpdate = false;

                    if (appUser.FirstName != user.FirstName)
                    {
                        appUser.FirstName = user.FirstName;
                        needsUpdate = true;
                    }

                    if (appUser.LastName != user.LastName)
                    {
                        appUser.LastName = user.LastName;
                        needsUpdate = true;
                    }

                    if (!string.IsNullOrEmpty(user.UserName) && appUser.UserName != user.UserName)
                    {
                        // Check if username is available
                        var userWithSameUsername = await _userManager.FindByNameAsync(user.UserName);
                        if (userWithSameUsername == null || userWithSameUsername.Id == appUser.Id)
                        {
                            appUser.UserName = user.UserName;
                            needsUpdate = true;
                        }
                    }

                    if (needsUpdate)
                    {
                        await _userManager.UpdateAsync(appUser);
                    }
                }

                // Generate tokens
                var accessToken = _tokenService.CreateToken(appUser);
                var refreshToken = _tokenService.CreateRefreshToken();

                // Update user with refresh token
                appUser.RefreshToken = refreshToken;
                appUser.RefreshTokenExpiryTime = DateTime.Now.AddDays(7);
                await _userManager.UpdateAsync(appUser);

                return Ok(new
                {
                    Token = accessToken,
                    RefreshToken = refreshToken,
                    Email = appUser.Email,
                    Name = appUser.UserName,
                    FirstName = appUser.FirstName,
                    LastName = appUser.LastName,
                    TelegramId = appUser.TelegramId,
                    ExpiresAt = DateTime.Now.AddMinutes(15),
                    Message = existingUser == null ? "User registered and authorized successfully" : "User authorized successfully"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "Internal server error", Error = ex.Message });
            }
        }

        [HttpPost("refresh-token")]
        public async Task<IActionResult> RefreshToken([FromBody] RefreshTokenDTO tokenRefreshDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var principal = _tokenService.GetPrincipalFromExpiredToken(tokenRefreshDto.Token);
                var userId = principal.FindFirstValue(ClaimTypes.NameIdentifier);

                if (string.IsNullOrEmpty(userId))
                {
                    return Unauthorized(new { Message = "Invalid token." });
                }

                var user = await _userManager.FindByIdAsync(userId);
                if (user == null)
                {
                    return Unauthorized(new { Message = "User not found." });
                }

                // Validate refresh token
                if (user.RefreshToken != tokenRefreshDto.RefreshToken ||
                    user.RefreshTokenExpiryTime <= DateTime.Now)
                {
                    return Unauthorized(new { Message = "Invalid or expired refresh token." });
                }

                // Generate new tokens
                var newAccessToken = _tokenService.CreateToken(user);
                var newRefreshToken = _tokenService.CreateRefreshToken();

                // Update user with new refresh token
                user.RefreshToken = newRefreshToken;
                user.RefreshTokenExpiryTime = DateTime.Now.AddDays(7);

                var result = await _userManager.UpdateAsync(user);
                if (!result.Succeeded)
                {
                    return BadRequest(new { Message = "Failed to update user.", Errors = result.Errors });
                }

                return Ok(new
                {
                    Token = newAccessToken,
                    RefreshToken = newRefreshToken,
                    Email = user.Email,
                    Name = user.UserName,
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    TelegramId = user.TelegramId,
                    ExpiresAt = DateTime.Now.AddMinutes(15)
                });
            }
            catch (Exception ex)
            {
                return Unauthorized(new { Message = "Invalid token.", Error = ex.Message });
            }
        }





    }
}
