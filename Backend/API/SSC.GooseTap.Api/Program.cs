
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SSC.GooseTap.Api.Middleware;
using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Business.Contracts.Infrastructure;
using SSC.GooseTap.Business.Services;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Infrastructure.Configuration;
using SSC.GooseTap.Infrastructure.Services;
using SSC.GooseTap.DataAccess.Context;
using SSC.GooseTap.DataAccess.Repositories;
using System.Reflection;

using DotNetEnv;

Env.Load();


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(option =>
{
    option.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "GooseTap API",
        Version = "v1",
        Description = "API for GooseTap Clicker Game."
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

    // Set the comments path for the Swagger JSON and UI.
    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    if (File.Exists(xmlPath))
    {
        option.IncludeXmlComments(xmlPath);
    }
});

// Database
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        // Оце той рядок, якого не вистачало для міграцій:
        b => b.MigrationsAssembly("SSC.GooseTap.DataAccess")
    ));

builder.Services.AddScoped<IUserRepository, UserRepository>();


// Identity

builder.Services.AddIdentity<ApplicationUser, IdentityRole<Guid>>(option =>
{
    //option.Password.RequireDigit = false;
    //option.Password.RequiredLength = 6;
    //option.Password.RequireLowercase = false;
    //option.Password.RequireUppercase = false;
    //option.Password.RequireNonAlphanumeric = false;
    option.SignIn.RequireConfirmedEmail = false;
}).AddEntityFrameworkStores<ApplicationDbContext>()
.AddDefaultTokenProviders();


// Authentication
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
        ValidIssuer = builder.Configuration["JWTSettings:Issuer"],
        ValidAudience = builder.Configuration["JWTSettings:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(builder.Configuration["JWTSettings:key"]))
    };
});

// Services Registration
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
builder.Services.AddScoped<IGenericRepository<Upgrade>, UpgradeRepository>();
builder.Services.AddScoped<IGenericRepository<ApplicationUser>, UserRepository>();

builder.Services.AddTransient<UpgradeService>();
builder.Services.AddTransient<IUserService, UserService>();
builder.Services.AddTransient<GameService>(); // New

builder.Services.AddTransient<IJwtTokenService, JwtTokenService>();
builder.Services.AddTransient<TelegramAuthService>(provider =>
{
    return new TelegramAuthService(builder.Configuration["Telegram:BotToken"]);
});

// Click Queue Services
builder.Services.AddSingleton<IClickQueue, ClickQueue>();
builder.Services.AddHostedService<ClickQueueBackgroundService>();


var emailSettings = builder.Configuration.GetSection("EmailSettings").Get<EmailSettings>();
builder.Services.AddSingleton(emailSettings);
builder.Services.AddTransient<IEmailService, EmailService>();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy => policy
            .AllowAnyOrigin() // In production, replace with specific origins
            .AllowAnyMethod()
            .AllowAnyHeader());
});


var app = builder.Build();

// Middleware Pipeline

app.UseMiddleware<GlobalExceptionHandlingMiddleware>(); // New Exception Middlewares

app.UseCors("AllowAll");


using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var logger = services.GetRequiredService<ILogger<Program>>();
    try
    {
        var context = services.GetRequiredService<ApplicationDbContext>();
        await context.Database.MigrateAsync();
        logger.LogInformation("Migrations Applied Successfully.");

        // if (app.Environment.IsDevelopment())
        // {
        //     await DataSeeder.SeedAsync(context);
        //     logger.LogInformation("Database Seeded Successfully.");
        // }
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "An error occurred while migrating the database.");
    }
}



// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment()) // Good practice to keep this check
//{
    app.UseSwagger();
    app.UseSwaggerUI();
//}
// For demo purposes allowing Swagger in prod too if manual removal is not desired, but safer to keep in dev block or configurable.

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

