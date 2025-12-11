using Moq;
using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Business.Requests;
using SSC.GooseTap.Business.Services;
using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Domain.Interfaces;

namespace SSC.GooseTap.Business.Tests
{
    [TestFixture]
    public class GameServiceTests
    {
        private Mock<IClickQueue> _mockClickQueue;
        private Mock<IUnitOfWork> _mockUnitOfWork;
        private Mock<IUserRepository> _mockUserRepository;
        private UserService _userService; // Ideally we should mock IUserService if GameService used interface, but it uses concrete UserService in constructor per previous view_file.
        // Wait, GameService constructor: public GameService(IClickQueue clickQueue, UserService userService)
        // If it takes concrete UserService, I need to pass a UserService instance.
         // And UserService takes IUnitOfWork. So I can mock IUnitOfWork -> IUserRepository.

        private GameService _gameService;

        [SetUp]
        public void Setup()
        {
            _mockClickQueue = new Mock<IClickQueue>();
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _mockUserRepository = new Mock<IUserRepository>();

            _mockUnitOfWork.Setup(u => u.UserRepository).Returns(_mockUserRepository.Object);
            
            _userService = new UserService(_mockUnitOfWork.Object);
            _gameService = new GameService(_mockClickQueue.Object, _userService);
        }

        [Test]
        public async Task ProcessClickAsync_ReturnsSuccess_WhenUserExists()
        {
            // Arrange
            var userId = Guid.NewGuid();
            var user = new ApplicationUser { Id = userId };
            _mockUserRepository.Setup(r => r.GetByIdAsync(userId)).ReturnsAsync(user);
            var request = new GameUpdateRequest();

            // Act
            var result = await _gameService.ProcessClickAsync(userId, request);

            // Assert
            Assert.That(result.Success, Is.True);
            _mockClickQueue.Verify(q => q.QueueBackgroundWorkItemAsync(userId, request), Times.Once);
        }

        [Test]
        public async Task ProcessClickAsync_ReturnsFailure_WhenUserNotFound()
        {
            // Arrange
            var userId = Guid.NewGuid();
            _mockUserRepository.Setup(r => r.GetByIdAsync(userId)).ReturnsAsync((ApplicationUser?)null);
            var request = new GameUpdateRequest();

            // Act
            var result = await _gameService.ProcessClickAsync(userId, request);

            // Assert
            Assert.That(result.Success, Is.False);
            Assert.That(result.Message, Is.EqualTo("User not found"));
            _mockClickQueue.Verify(q => q.QueueBackgroundWorkItemAsync(It.IsAny<Guid>(), It.IsAny<GameUpdateRequest>()), Times.Never);
        }
    }
}
