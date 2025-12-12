using SSC.GooseTap.Business.Requests;

namespace SSC.GooseTap.Business.Contracts
{
    public interface IClickQueue
    {
        ValueTask QueueBackgroundWorkItemAsync(Guid userId, GameUpdateRequest workItem);
        ValueTask<(Guid UserId, GameUpdateRequest WorkItem)> DequeueAsync(CancellationToken cancellationToken);
    }
}
