using System;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SSC.GooseTap.Business.Services;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UpgradesController(UpgradeService upgradeService, SSC.GooseTap.Business.Contracts.IUserService userService) : ControllerBase
    {
        [HttpGet("GetAll")]
        [AllowAnonymous]
        public async Task<IActionResult> GetAllUpgrades()
        {
            try
            {
                var upgrades = await upgradeService.GetAllUpgradesAsync();

                // If user is authenticated, include user-specific state
                ApplicationUser? user = null;
                if (User.Identity?.IsAuthenticated == true)
                {
                    var userIdString = User.FindFirst("Id")?.Value;
                    if (Guid.TryParse(userIdString, out var userId))
                    {
                        user = await userService.GetUserByIdAsync(userId);
                    }
                }

                var list = upgrades.Select(u => new SSC.GooseTap.Business.DTOs.UpgradeDto
                {
                    Id = u.Id,
                    Name = u.Name,
                    Description = u.Description,
                    BaseCost = u.BaseCost,
                    BaseProfitPerHour = u.BaseProfitPerHour,
                    UserLevel = user?.UserUpgrades?.FirstOrDefault(x => x.UpgradeId == u.Id)?.Level ?? 0,
                    NextLevelPrice = u.BaseCost * ((user?.UserUpgrades?.FirstOrDefault(x => x.UpgradeId == u.Id)?.Level ?? 0) + 1),
                    IsAvailable = user != null && user.Balance >= u.BaseCost * ((user?.UserUpgrades?.FirstOrDefault(x => x.UpgradeId == u.Id)?.Level ?? 0) + 1)
                }).ToList();

                return Ok(new { Message = "List of all upgrades.", Upgrades = list });
            }
            catch (Exception ex)
            {
                return BadRequest(new
                {
                    Message = "An error occurred while retrieving upgrades.",
                    Error = ex.Message
                }
                );

            }
        }

        [HttpPost("Buy")]
        [Authorize]
        public async Task<IActionResult> BuyUpgrade([FromBody] SSC.GooseTap.Business.Requests.BuyUpgradeRequest request)
        {
            var userIdString = User.FindFirst("Id")?.Value;
            if (!Guid.TryParse(userIdString, out var userId))
            {
                return Unauthorized();
            }

            var result = await upgradeService.BuyUpgradeAsync(userId, request.UpgradeId);
            if (!result.Success)
                return BadRequest(result);

            return Ok(result);
        }
    }
}
