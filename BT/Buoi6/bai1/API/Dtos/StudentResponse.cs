namespace StudentApi.Dtos;

/// <summary>Thông tin sinh viên được trả về bởi API.</summary>
public sealed record StudentResponse(
    int Id,
    string MaSinhVien,
    string HoTen,
    DateTimeOffset? NgaySinh,
    string? GioiTinh,
    string? Email,
    string? SoDienThoai,
    string? Lop,
    string? DiaChi);