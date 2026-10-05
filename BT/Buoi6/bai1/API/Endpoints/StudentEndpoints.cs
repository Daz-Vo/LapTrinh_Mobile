using Microsoft.AspNetCore.Http.HttpResults;
using StudentApi.Dtos;
using StudentApi.Services;

namespace StudentApi.Endpoints;

public static class StudentEndpoints
{
    public static IEndpointRouteBuilder MapStudentEndpoints(this IEndpointRouteBuilder endpoints)
    {
        endpoints.MapGet("/api/sinhvien", async Task<Ok<IReadOnlyList<StudentResponse>>>(
            IStudentService studentService,
            CancellationToken cancellationToken) =>
        {
            var students = await studentService.GetAllAsync(cancellationToken);
            return TypedResults.Ok(students);
        })
        .WithName("GetAllStudents")
        .WithSummary("Lấy danh sách sinh viên")
        .WithDescription("Trả về danh sách sinh viên đọc từ bảng dbo.SinhVien.")
        .Produces<IReadOnlyList<StudentResponse>>(StatusCodes.Status200OK);

        return endpoints;
    }
}