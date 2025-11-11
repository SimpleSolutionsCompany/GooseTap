using Application.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UpgradesController : ControllerBase
    {
        private readonly UpgradeService _upgradeService;

        public UpgradesController(UpgradeService upgradeService)
        {
            _upgradeService = upgradeService;
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAllUpgrades()
        {
            try
            {
                var upgrades = await _upgradeService.GetAllUpgrades();
                return Ok(new 
                { 
                    Message = "List of all upgrades.",
                    Upgrades = upgrades 
                });
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
    }
}
