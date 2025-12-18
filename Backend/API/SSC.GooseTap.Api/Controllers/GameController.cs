using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SSC.GooseTap.Business.Services;
using System.Security.Claims;

namespace SSC.GooseTap.Api.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    [Authorize]
    public class GameController(IGameService gameService) : ControllerBase
    {
        [HttpGet("upgrades")]
        public async Task<IActionResult> GetUpgrades()
        {
            var userId = GetUserId();
            var result = await gameService.GetUpgradesAsync(userId);
            
            if (result.IsSuccess) return Ok(result.Value);
            return BadRequest(result.Error);
        }

        [HttpPost("buy/{upgradeId}")]
        public async Task<IActionResult> BuyUpgrade(Guid upgradeId)
        {
            var userId = GetUserId();
            var result = await gameService.BuyUpgradeAsync(userId, upgradeId);

            if (result.IsSuccess) return Ok(result.Value);
            return BadRequest(result.Error);
        }

        [HttpPost("click")]
        public async Task<IActionResult> Click()
        {
            var userId = GetUserId();
            var result = await gameService.ClickAsync(userId);

            if (result.IsSuccess) return Ok(result.Value);
            return BadRequest(result.Error);
        }

        [HttpGet("sync")]
        public async Task<IActionResult> Sync()
        {
            var userId = GetUserId();
            var result = await gameService.SyncAsync(userId);

            if (result.IsSuccess) return Ok(result.Value);
            return BadRequest(result.Error);
        }

        private Guid GetUserId()
        {
            var idClaim = User.FindFirst("Id")?.Value;
            if (string.IsNullOrEmpty(idClaim)) throw new UnauthorizedAccessException("User ID not found in token");
            return Guid.Parse(idClaim);
        }
    }
}
