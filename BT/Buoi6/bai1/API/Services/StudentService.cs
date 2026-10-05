using Microsoft.EntityFrameworkCore;
using StudentApi.Data;
using StudentApi.Dtos;

namespace StudentApi.Services;

public sealed class StudentService(StudentDbContext dbContext) : IStudentService
{
    public async Task<IReadOnlyList<StudentResponse>> GetAllAsync(
        CancellationToken cancellationToken)
    {
        var students = await dbContext.Students
            .AsNoTracking()
            .OrderBy(student => student.MaSinhVien)
            .ToListAsync(cancellationToken);

        return students.Select(student => new StudentResponse(
            student.Id,
            student.MaSinhVien,
            student.HoTen,
            student.NgaySinh is DateTime dateOfBirth
                ? new DateTimeOffset(DateTime.SpecifyKind(dateOfBirth, DateTimeKind.Utc))
                : null,
            student.GioiTinh,
            student.Email,
            student.SoDienThoai,
            student.Lop,
            student.DiaChi)).ToArray();
    }
}