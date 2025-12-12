using SSC.GooseTap.Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace SSC.GooseTap.Business.Contracts.Infrastructure
{
    public interface IJwtTokenService
    {
        string CreateToken(ApplicationUser applicationUser);
        string CreateRefreshToken();
        ClaimsPrincipal GetPrincipalFromExpiredToken(string token);
    }
}
