using Moq;
using SSC.GooseTap.Business.Services;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Tests
{
    [TestFixture]
    public class UpgradeServiceTests
    {
        private Mock<IUnitOfWork> _mockUnitOfWork;
        private Mock<IUpgradeRepository> _mockUpgradeRepository;
        private UpgradeService _upgradeService;

        [SetUp]
        public void Setup()
        {
            _mockUnitOfWork = new Mock<IUnitOfWork>();
            _mockUpgradeRepository = new Mock<IUpgradeRepository>();
            _mockUnitOfWork.Setup(u => u.UpgradeRepository).Returns(_mockUpgradeRepository.Object);
            _upgradeService = new UpgradeService(_mockUnitOfWork.Object);
        }

        [Test]
        public async Task CreateUpgradeAsync_AddsUpgradeAndSaves()
        {
            // Arrange
            var upgrade = new Upgrade { Name = "Test Upgrade" };

            // Act
            var result = await _upgradeService.CreateUpgradeAsync(upgrade);

            // Assert
            Assert.That(result, Is.EqualTo(upgrade.Id));
            _mockUpgradeRepository.Verify(r => r.AddAsync(upgrade), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(), Times.Once);
        }

        [Test]
        public async Task GetAllUpgradesAsync_ReturnsUpgrades()
        {
            // Arrange
            var upgrades = new List<Upgrade> { new Upgrade { Name = "U1" }, new Upgrade { Name = "U2" } };
            _mockUpgradeRepository.Setup(r => r.GetAllAsync()).ReturnsAsync(upgrades);

            // Act
            var result = await _upgradeService.GetAllUpgradesAsync();

            // Assert
            Assert.That(result.Count(), Is.EqualTo(2));
            _mockUpgradeRepository.Verify(r => r.GetAllAsync(), Times.Once);
        }

        [Test]
        public async Task GetUpgradeByIdAsync_ReturnsUpgrade_WhenExists()
        {
            // Arrange
            var upgradeId = Guid.NewGuid();
            var upgrade = new Upgrade { Id = upgradeId };
            _mockUpgradeRepository.Setup(r => r.GetByIdAsync(upgradeId)).ReturnsAsync(upgrade);

            // Act
            var result = await _upgradeService.GetUpgradeByIdAsync(upgradeId);

            // Assert
            Assert.That(result, Is.EqualTo(upgrade));
        }

        [Test]
        public async Task UpdateUpgradeAsync_UpdatesAndSaves()
        {
            // Arrange
            var upgrade = new Upgrade { Id = Guid.NewGuid(), Name = "Updated" };

            // Act
            await _upgradeService.UpdateUpgradeAsync(upgrade);

            // Assert
            _mockUpgradeRepository.Verify(r => r.UpdateAsync(upgrade), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(), Times.Once);
        }

        [Test]
        public async Task DeleteUpgradeAsync_DeletesAndSaves_WhenUpgradeExists()
        {
            // Arrange
            var upgradeId = Guid.NewGuid();
            var upgrade = new Upgrade { Id = upgradeId };
            _mockUpgradeRepository.Setup(r => r.GetByIdAsync(upgradeId)).ReturnsAsync(upgrade);

            // Act
            await _upgradeService.DeleteUpgradeAsync(upgradeId);

            // Assert
            _mockUpgradeRepository.Verify(r => r.DeleteAsync(upgrade), Times.Once);
            _mockUnitOfWork.Verify(u => u.SaveChangesAsync(), Times.Once);
        }
    }
}
