using StudentApi.Dtos;

namespace StudentApi.Services;

public interface IStudentService
{
    Task<IReadOnlyList<StudentResponse>> GetAllAsync(CancellationToken cancellationToken);
}