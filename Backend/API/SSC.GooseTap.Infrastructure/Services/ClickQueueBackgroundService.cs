using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Business.Requests;
using SSC.GooseTap.DataAccess.Context;

namespace SSC.GooseTap.Infrastructure.Services
{
    public class ClickQueueBackgroundService(
        IClickQueue taskQueue,
        IServiceScopeFactory serviceScopeFactory,
        ILogger<ClickQueueBackgroundService> logger) : BackgroundService
    {
        private readonly IClickQueue _taskQueue = taskQueue;
        private readonly IServiceScopeFactory _serviceScopeFactory = serviceScopeFactory;
        private readonly ILogger<ClickQueueBackgroundService> _logger = logger;

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("ClickQueueBackgroundService is starting.");

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    var (userId, request) = await _taskQueue.DequeueAsync(stoppingToken);
                    await ProcessClickAsync(userId, request);
                }
                catch (OperationCanceledException)
                {
                    // Prevent throwing if stoppingToken was signaled
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error occurred executing background work item.");
                }
            }
            
            _logger.LogInformation("ClickQueueBackgroundService is stopping.");
        }

        private async Task ProcessClickAsync(Guid userId, GameUpdateRequest request)
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
                
                var user = await dbContext.Users.FindAsync(userId.ToString());
                if (user != null)
                {
                     if (request.EnergySpent > user.CurrentEnergy + user.EnergyRestorePerSecond * 5)
                     {
                          user.Balance += user.ProfitPerClick * user.CurrentEnergy + 5 * user.EnergyRestorePerSecond;
                          user.CurrentEnergy = 0;
                     }
                     else
                     {
                          user.Balance += user.ProfitPerClick * request.Clicks;
                          user.CurrentEnergy -= request.EnergySpent;
                          if (user.CurrentEnergy <= user.MaxEnergy - 5)
                          {
                              user.CurrentEnergy += 5;
                              user.LastEnergyRestoreTime = DateTime.UtcNow;
                          }
                     }

                     await dbContext.SaveChangesAsync();
                }
            }
        }
    }
}
