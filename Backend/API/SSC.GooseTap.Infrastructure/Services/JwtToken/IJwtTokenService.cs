using System.Security.Claims;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Infrastructure.Services.JwtToken;

public interface IJwtTokenService
{
    string CreateToken(ApplicationUser applicationUser);
    string CreateRefreshToken();
    ClaimsPrincipal GetPrincipalFromExpiredToken(string token);
    
}