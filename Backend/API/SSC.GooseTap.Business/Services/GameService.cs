using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Business.Requests;
using SSC.GooseTap.Business.Responces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Services
{
    public class GameService(IClickQueue clickQueue, UserService userService)
    {
        private readonly IClickQueue _clickQueue = clickQueue;
        private readonly UserService _userService = userService;

        public async Task<ApiResponse<string>> ProcessClickAsync(Guid userId, GameUpdateRequest request)
        {
            // 1. Basic Validation (Sync)
            var user = await _userService.GetUserByIdAsync(userId);
            if (user == null)
            {
                return new ApiResponse<string>("User not found") { Success = false };
            }

            // 2. Queue the work
            // We moved the heavy DB update logic to background
            await _clickQueue.QueueBackgroundWorkItemAsync(userId, request);

            return new ApiResponse<string>("Click queued successfully", "Success");
        }
    }
}
