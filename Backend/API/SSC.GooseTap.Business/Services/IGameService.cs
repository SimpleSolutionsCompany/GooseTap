using SSC.GooseTap.Business.DTOs;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Services
{
    public interface IGameService
    {
        Task<Result<IEnumerable<UpgradeDto>>> GetUpgradesAsync(Guid userId);
        Task<Result<BuyUpgradeResponseDto>> BuyUpgradeAsync(Guid userId, Guid upgradeId);
        Task<Result<ClickResponseDto>> SyncAsync(Guid userId, SyncGameRequestDto? request);
    }
}
