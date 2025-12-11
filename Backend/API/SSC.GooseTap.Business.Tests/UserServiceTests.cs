using Moq;
using SSC.GooseTap.Business.Services;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Tests
{
    [TestFixture]
    public class UserServiceTests
    {
        private Mock<IUnitOfWork> _mockUnitOfWork;
        private Mock<IUserRepository> _mockUserRepository;
        private UserService _userService;

        [SetUp]
        public void Setup()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _mockUserRepository = new Mock<IUserRepository>();
            _mockUnitOfWork.Setup(u => u.UserRepository).Returns(_mockUserRepository.Object);
            _userService = new UserService(_mockUnitOfWork.Object);
        }

        [Test]
        public async Task GetUserByIdAsync_ReturnsUser_WhenUserExists()
        {
            // Arrange
            var userId = Guid.NewGuid();
            var expectedUser = new ApplicationUser { Id = userId, TelegramId = "12345" };
            _mockUserRepository.Setup(r => r.GetByIdAsync(userId)).ReturnsAsync(expectedUser);

            // Act
            var result = await _userService.GetUserByIdAsync(userId);

            // Assert
            Assert.That(result, Is.Not.Null);
            Assert.That(result!.Id, Is.EqualTo(userId));
            _mockUserRepository.Verify(r => r.GetByIdAsync(userId), Times.Once);
        }

        [Test]
        public async Task GetUserByTgIdAsync_ReturnsUser_WhenUserExists()
        {
            // Arrange
            var tgId = "12345";
            var expectedUser = new ApplicationUser { Id = Guid.NewGuid(), TelegramId = tgId };
            _mockUserRepository.Setup(r => r.GetByTgIdAsync(tgId)).ReturnsAsync(expectedUser);

            // Act
            var result = await _userService.GetUserByTgIdAsync(tgId);

            // Assert
            Assert.That(result, Is.Not.Null);
            Assert.That(result.TelegramId, Is.EqualTo(tgId));
            _mockUserRepository.Verify(r => r.GetByTgIdAsync(tgId), Times.Once);
        }

        [Test]
        public async Task UpdateUserAsync_CallsUpdateAndSaveChanges()
        {
            // Arrange
            var user = new ApplicationUser { Id = Guid.NewGuid(), TelegramId = "UpdateTest" };
            
            // Act
            await _userService.UpdateUserAsync(user);

            // Assert
            _mockUserRepository.Verify(r => r.UpdateAsync(user), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(), Times.Once);
        }

        [Test]
        public async Task DeleteUserAsync_CallsDeleteAndSaveChanges_WhenUserExists()
        {
             // Arrange
            var userId = Guid.NewGuid();
            var user = new ApplicationUser { Id = userId };
            _mockUserRepository.Setup(r => r.GetByIdAsync(userId)).ReturnsAsync(user);

            // Act
            await _userService.DeleteUserAsync(userId);

            // Assert
            _mockUserRepository.Verify(r => r.DeleteAsync(user), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(), Times.Once);
        }

        [Test]
        public async Task GetAllUsersAsync_ReturnsAllUsers()
        {
            // Arrange
            var users = new List<ApplicationUser> 
            { 
                new ApplicationUser { TelegramId = "1" }, 
                new ApplicationUser { TelegramId = "2" } 
            };
            _mockUserRepository.Setup(r => r.GetAllAsync()).ReturnsAsync(users);

            // Act
            var result = await _userService.GetAllUsersAsync();

            // Assert
            Assert.That(result.Count(), Is.EqualTo(2));
            _mockUserRepository.Verify(r => r.GetAllAsync(), Times.Once);
        }
    }
}
