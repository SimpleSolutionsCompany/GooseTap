using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SSC.GooseTap.DataAccess.Context;

namespace SSC.GooseTap.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminController : ControllerBase
    {
        private readonly ApplicationDbContext _dbContext;
        public AdminController(ApplicationDbContext dbContext)
        {
            _dbContext = dbContext;
        }


        [HttpGet("ClearDB")]
        public IActionResult HealthCheck()
        {
            _dbContext.Database.EnsureDeleted();
            _dbContext.Database.EnsureCreated();

            return Ok(new
            {
                Status = "Clear",
                Timestamp = DateTime.UtcNow
            });
        }
    }
}
