namespace StudentApi.Models;

public sealed class Student
{
    public int Id { get; set; }
    public required string MaSinhVien { get; set; }
    public required string HoTen { get; set; }
    public DateTime? NgaySinh { get; set; }
    public string? GioiTinh { get; set; }
    public string? Email { get; set; }
    public string? SoDienThoai { get; set; }
    public string? Lop { get; set; }
    public string? DiaChi { get; set; }
}