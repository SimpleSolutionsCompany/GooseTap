using System.Threading.Channels;
using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Business.Requests;

namespace SSC.GooseTap.Infrastructure.Services
{
    public class ClickQueue : IClickQueue
    {
        private readonly Channel<(Guid UserId, GameUpdateRequest WorkItem)> _queue;

        public ClickQueue()
        {
            // Unbounded channel for high throughput.
            var options = new UnboundedChannelOptions
            {
                SingleReader = true
            };
            _queue = Channel.CreateUnbounded<(Guid, GameUpdateRequest)>(options);
        }

        public async ValueTask QueueBackgroundWorkItemAsync(Guid userId, GameUpdateRequest workItem)
        {
            if (workItem == null)
            {
                throw new ArgumentNullException(nameof(workItem));
            }

            await _queue.Writer.WriteAsync((userId, workItem));
        }

        public async ValueTask<(Guid UserId, GameUpdateRequest WorkItem)> DequeueAsync(CancellationToken cancellationToken)
        {
            return await _queue.Reader.ReadAsync(cancellationToken);
        }
    }
}
