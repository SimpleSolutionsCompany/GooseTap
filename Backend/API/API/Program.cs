// --- Змінив using-и відповідно до твоєї структури проєкту ---
using Domain.Models;
using Persistence.Context; // <--- Змінено (беремо з проєкту Persistence)
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;

// --- ДОДАНО: using-и для Dependency Injection ---
using Application.Contracts.Persistence; // Інтерфейси IUnitOfWork, IGenericRepository
using Persistence.Repositories; // <--- Змінено (реалізація з проєкту Persistence)

using Application.Contracts.Infrastructure; // Інтерфейси IJwtTokenService, IRedisCacheService
using Infrastructure.Services; // <--- Змінено (реалізація з Infrastructure.Services)

using Infrastructure.Configuration;
using Application.Services;

// TODO: Додай правильний namespace для AutoMapper профілів
// using Application.Mapping;

var builder = WebApplication.CreateBuilder(args);


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
//builder.Services.AddSwaggerGen();



builder.Services.AddSwaggerGen(option =>
{
    option.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "JWT_N1 API",
        Version = "v1",
        Description = "An example API for demonstrating authentication with JWT."
    });

    option.AddSecurityDefinition("Bearer", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        In = Microsoft.OpenApi.Models.ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.ApiKey,

    });

    option.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
        {
            new Microsoft.OpenApi.Models.OpenApiSecurityScheme
            {
                Reference = new Microsoft.OpenApi.Models.OpenApiReference
                {
                    Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] {}
        }
    });
});

// 👇 Connection string тепер можна брати з .env або Environment Variables
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));


builder.Services.AddIdentity<ApplicationUser, IdentityRole>(option =>
{
    //option.Password.RequireDigit = false;
    //option.Password.RequiredLength = 6;
    //option.Password.RequireLowercase = false;
    //option.Password.RequireUppercase = false;
    //option.Password.RequireNonAlphanumeric = false;
    option.SignIn.RequireConfirmedEmail = false;
}).AddEntityFrameworkStores<ApplicationDbContext>()
.AddDefaultTokenProviders();



builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(option =>
{
    option.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["JWTSettings:Issuer"], // 👈 береться з ENV або .env
        ValidAudience = builder.Configuration["JWTSettings:Audience"], // 👈 береться з ENV або .env
        IssuerSigningKey = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(builder.Configuration["JWTSettings:key"])) // 👈 береться з ENV або .env
    };
});


//builder.Services.AddTransient<TokenService>();
//builder.Services.AddTransient<IJwtTokenService, JwtTokenService>();
//builder.Services.AddTransient<IRedisCacheService, RedisCacheService>();
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
builder.Services.AddScoped<IGenericRepository<Upgrade>, UpgradeRepository>();
builder.Services.AddTransient<UpgradeService>();

builder.Services.AddTransient<IJwtTokenService, JwtTokenService>();
builder.Services.AddTransient<TelegramAuthService>(provider =>
{
    return new TelegramAuthService(builder.Configuration["Telegram:BotToken"]);
});



// 👇 EmailSettings тепер теж через ENV або .env
var emailSettings = builder.Configuration.GetSection("EmailSettings").Get<EmailSettings>();
builder.Services.AddSingleton(emailSettings);
builder.Services.AddTransient<IEmailService, EmailService>();



//builder.Services.AddAutoMapper(typeof(MappingProfile));



//builder.Services.AddCors(options =>
//{
//    options.AddPolicy("AllowAll", policy =>
//        policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
//});

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy => policy
            .AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader());
});





var app = builder.Build();

//ApplyMigrations(app);


app.UseCors("AllowAll");

//using (var scope = app.Services.CreateScope())
//{
//    var db = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
//    db.Database.Migrate();
//}



//ServiceLocator.SetLocatorProvider(app.Services);

// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
app.UseSwagger();
app.UseSwaggerUI();
//}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

