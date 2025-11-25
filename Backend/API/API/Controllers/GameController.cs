using Application.Request;
using Application.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class GameController : ControllerBase
    {
        private readonly UserService _userService;

        public GameController(UserService userService)
        {
            _userService = userService;
        }

        [HttpPost("Click")]
        public IActionResult Click([FromBody] GameUpdateRequest request)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var AppUser = _userService.GetUserByIdAsync(userId);

            if (AppUser != null)
            {
                if (request.EnergySpent > AppUser.Result.CurrentEnergy + AppUser.Result.EnergyRestorePerSecond * 5)
                {
                    AppUser.Result.Balance += AppUser.Result.ProfitPerClick * AppUser.Result.CurrentEnergy +
                                              5 * AppUser.Result.EnergyRestorePerSecond ;
                    AppUser.Result.CurrentEnergy = 0;
                }
                else
                {
                    AppUser.Result.Balance += AppUser.Result.ProfitPerClick * request.Clicks;
                    AppUser.Result.CurrentEnergy -= request.EnergySpent;
                    if (AppUser.Result.CurrentEnergy <= AppUser.Result.MaxEnergy - 5)
                    {
                        AppUser.Result.CurrentEnergy += 5;
                        AppUser.Result.LastEnergyRestoreTime = DateTime.Now;
                    }
                }
            }

            return Ok();
        }
    }
}
