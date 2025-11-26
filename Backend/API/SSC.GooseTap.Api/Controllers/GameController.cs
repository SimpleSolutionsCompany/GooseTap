using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SSC.GooseTap.Business.Requests;
using SSC.GooseTap.Business.Services;

namespace SSC.GooseTap.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class GameController(UserService userService) : ControllerBase
    {
        [HttpPost("Click")]
        public IActionResult Click([FromBody] GameUpdateRequest request)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var AppUser = userService.GetUserByIdAsync(userId);

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
