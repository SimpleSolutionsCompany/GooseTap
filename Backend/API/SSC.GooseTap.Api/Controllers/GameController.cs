using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SSC.GooseTap.Business.Requests;
using SSC.GooseTap.Business.Responces;
using SSC.GooseTap.Business.Services;
using System.Security.Claims;

namespace SSC.GooseTap.Api.Controllers
{
    /// <summary>
    /// Controller for handling game interactions.
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class GameController(GameService gameService) : ControllerBase
    {
        private readonly GameService _gameService = gameService;

        /// <summary>
        /// Processes a click action, updating user balance and energy.
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /api/Game/Click
        ///     {
        ///        "clicks": 10,
        ///        "energySpent": 5,
        ///        "timestamp": "2023-10-01T12:00:00Z"
        ///     }
        ///
        /// </remarks>
        /// <param name="request">The click update request containing clicks and energy spent.</param>
        /// <returns>A standard API response indicating success or failure.</returns>
        /// <response code="200">Returns success if the click was processed (queued).</response>
        /// <response code="400">If the request is invalid.</response>
        /// <response code="401">If the user is not authenticated.</response>
        [HttpPost("Click")]
        [ProducesResponseType(typeof(ApiResponse<string>), 200)]
        [ProducesResponseType(typeof(ApiResponse<string>), 400)]
        [ProducesResponseType(401)]
        public async Task<IActionResult> Click([FromBody] GameUpdateRequest request)
        {
            var userIdString = User.FindFirst("Id")?.Value;
            if (!Guid.TryParse(userIdString, out var userId))
            {
                return Unauthorized(new ApiResponse<string>("Invalid User ID"));
            }

            var result = await _gameService.ProcessClickAsync(userId, request);

            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("Sync")]
        [ProducesResponseType(typeof(SSC.GooseTap.Business.Responces.CheckpointResponse), 200)]
        public async Task<IActionResult> Sync([FromBody] SSC.GooseTap.Business.Requests.SyncRequest request)
        {
            var userIdString = User.FindFirst("Id")?.Value;
            if (!Guid.TryParse(userIdString, out var userId))
            {
                return Unauthorized(new SSC.GooseTap.Business.Responces.ApiResponse<string>("Invalid User ID"));
            }

            var syncResult = await _gameService.SyncAsync(userId, request);
            if (!syncResult.Success)
                return BadRequest(syncResult);

            return Ok(syncResult);
        }
    }
}
