using Microsoft.EntityFrameworkCore;
using StudentApi.Models;

namespace StudentApi.Data;

public sealed class StudentDbContext(DbContextOptions<StudentDbContext> options)
    : DbContext(options)
{
    public DbSet<Student> Students => Set<Student>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        var student = modelBuilder.Entity<Student>();
        student.ToTable("SinhVien", "dbo");
        student.HasKey(item => item.Id);
        student.HasIndex(item => item.MaSinhVien).IsUnique();

        student.Property(item => item.Id).HasColumnName("Id");
        student.Property(item => item.MaSinhVien)
            .HasColumnName("MaSinhVien")
            .HasMaxLength(20)
            .IsRequired();
        student.Property(item => item.HoTen)
            .HasColumnName("HoTen")
            .HasMaxLength(100)
            .IsRequired();
        student.Property(item => item.NgaySinh).HasColumnName("NgaySinh").HasColumnType("date");
        student.Property(item => item.GioiTinh).HasColumnName("GioiTinh").HasMaxLength(10);
        student.Property(item => item.Email).HasColumnName("Email").HasMaxLength(254);
        student.Property(item => item.SoDienThoai).HasColumnName("SoDienThoai").HasMaxLength(20);
        student.Property(item => item.Lop).HasColumnName("Lop").HasMaxLength(50);
        student.Property(item => item.DiaChi).HasColumnName("DiaChi").HasMaxLength(255);
    }
}