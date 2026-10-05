using Microsoft.EntityFrameworkCore;
using StudentApi.Data;
using StudentApi.Endpoints;
using StudentApi.Services;

var builder = WebApplication.CreateBuilder(args);

var connectionString = builder.Configuration.GetConnectionString("StudentDb");
if (string.IsNullOrWhiteSpace(connectionString))
{
    throw new InvalidOperationException(
        "Connection string 'StudentDb' is missing. Set it with .NET User Secrets.");
}

builder.Services.AddDbContext<StudentDbContext>(options =>
    options.UseSqlServer(connectionString));
builder.Services.AddScoped<IStudentService, StudentService>();
builder.Services.AddOpenApi();
builder.Services.AddProblemDetails();
builder.Services.AddCors(options =>
{
    options.AddPolicy("FlutterDevelopment", policy =>
        policy.SetIsOriginAllowed(origin =>
            Uri.TryCreate(origin, UriKind.Absolute, out var uri) &&
            uri.Scheme is "http" or "https" &&
            (uri.Host == "localhost" || uri.Host == "127.0.0.1"))
        .AllowAnyHeader()
        .WithMethods("GET"));
});

var app = builder.Build();

app.UseExceptionHandler();
app.UseStatusCodePages();

if (app.Environment.IsDevelopment())
{
    app.UseCors("FlutterDevelopment");
    app.MapOpenApi();
}

app.MapStudentEndpoints();

app.Run();