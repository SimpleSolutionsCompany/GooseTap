using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace GooseTapBackend.Controllers
{
    [Route("api/userdata")]
    [ApiController]
    public class UserController : ControllerBase
    {
        [HttpGet]
        public IActionResult<string> GetName(int userId)
        {
            var str = "Nazar";
            return  Unauthorized(str);
        }
    }
}
