using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SSC.GooseTap.Business.Services;

namespace SSC.GooseTap.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UpgradesController(UpgradeService upgradeService) : ControllerBase
    {
        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAllUpgrades()
        {
            try
            {
                var upgrades = await upgradeService.GetAllUpgrades();
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
