# Bài tập: Danh sách sinh viên

Ứng dụng Flutter tải danh sách sinh viên từ ASP.NET Core Web API. Backend đọc dữ liệu từ SQL Server.

```text
Flutter app  ->  ASP.NET Core API  ->  SQL Server
```

## Cấu trúc

- `API/`: backend .NET 10, endpoint danh sách sinh viên.
- `lib/main.dart`: giao diện Flutter, model và gọi API.
- `android/app/src/main/AndroidManifest.xml`: quyền Internet và cho phép HTTP trong môi trường phát triển.
- `test/widget_test.dart`: kiểm tra parse JSON thành model sinh viên.

## Yêu cầu

- Garuda Linux / Arch Linux
- Flutter SDK và Android SDK nếu chạy Android
- .NET 10 SDK cùng ASP.NET Core runtime
- SQL Server có thể kết nối từ máy chạy backend
- Database `LapTrinhMobile` có bảng `dbo.SinhVien` và dữ liệu mẫu

Cài .NET trên Garuda nếu máy chưa có:

```bash
sudo pacman -Syu dotnet-sdk aspnet-runtime
dotnet --list-runtimes
```

Kết quả cần có `Microsoft.AspNetCore.App 10.0.x`.

## Cấu hình database

Backend đọc cấu hình `ConnectionStrings:StudentDb` từ `API/appsettings.json`. Điền host SQL Server, database `LapTrinhMobile`, tài khoản và mật khẩu của bạn. Host `sqlserver_db` chỉ dùng được khi backend chạy trong cùng mạng Docker với SQL Server.

### Tạo bảng sinh viên trong DBeaver

Trong DBeaver, chọn database `LapTrinhMobile`, mở SQL Editor và chạy câu lệnh sau. Không cần thêm `GO`. Chỉ chạy nếu bảng `dbo.SinhVien` chưa tồn tại:

```sql
CREATE TABLE dbo.SinhVien
(
	Id INT IDENTITY(1,1) NOT NULL
		CONSTRAINT PK_SinhVien PRIMARY KEY,
	MaSinhVien NVARCHAR(20) NOT NULL,
	HoTen NVARCHAR(100) NOT NULL,
	NgaySinh DATE NULL,
	GioiTinh NVARCHAR(10) NULL,
	Email NVARCHAR(254) NULL,
	SoDienThoai VARCHAR(20) NULL,
	Lop NVARCHAR(50) NULL,
	DiaChi NVARCHAR(255) NULL,
	CONSTRAINT UQ_SinhVien_MaSinhVien UNIQUE (MaSinhVien)
);
```

`MaSinhVien` là duy nhất; `Id` tự tăng. Sau khi tạo bảng, nạp dữ liệu mẫu rồi chạy API.

Không commit mật khẩu thật vào Git. Có thể lưu chuỗi kết nối bằng User Secrets từ workspace root:

```bash
dotnet user-secrets set 'ConnectionStrings:StudentDb' 'Server=YOUR_SQL_SERVER_HOST,1433;Database=LapTrinhMobile;User Id=sa;Password=YOUR_PASSWORD;Encrypt=True;TrustServerCertificate=True' --project API/StudentApi.csproj
```

Thay `YOUR_SQL_SERVER_HOST` và `YOUR_PASSWORD` bằng thông tin database. Khi chạy ở Development, User Secrets ghi đè giá trị cùng khóa trong `appsettings.json`. Nếu muốn dùng `appsettings.json`, xóa override cũ:

```bash
dotnet user-secrets remove 'ConnectionStrings:StudentDb' --project API/StudentApi.csproj
```

## Chạy backend

Mở terminal tại `BT/buoi6`:

```bash
cd API
dotnet build StudentApi.csproj
env ASPNETCORE_ENVIRONMENT=Development dotnet bin/Debug/net10.0/StudentApi.dll --urls http://0.0.0.0:5080
```

Giữ terminal này mở. Chạy DLL từ thư mục `API` để ASP.NET Core tìm được `appsettings.json` và tránh gọi apphost trực tiếp trên ổ removable.

## Chạy Flutter

Mở terminal thứ hai tại `BT/buoi6`:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

API URL mặc định theo thiết bị:

- Linux desktop: `http://127.0.0.1:5080/api/sinhvien`
- Android Emulator: `http://10.0.2.2:5080/api/sinhvien`

Với điện thoại Android thật, máy tính và điện thoại cần chung Wi-Fi. Truyền IP LAN của máy chạy backend:

```bash
flutter run --dart-define=STUDENT_API_URL=http://YOUR_COMPUTER_IP:5080/api/sinhvien
```

Thay `YOUR_COMPUTER_IP` bằng IP LAN của máy tính và cho phép firewall nhận kết nối cổng `5080`.

### Lưu ý ổ removable

Workspace hiện nằm dưới `/run/media`; filesystem này không giữ quyền execute cho `android/gradlew`. Vì vậy build APK có thể báo không đủ quyền chạy Gradle wrapper. Hãy chuyển/copy project sang filesystem Linux như thư mục home rồi chạy Flutter từ đó. Không cần chuyển database.

## Kiểm tra API

- Danh sách sinh viên: <http://localhost:5080/api/sinhvien>
- OpenAPI JSON: <http://localhost:5080/openapi/v1.json>

Hoặc gọi bằng terminal:

```bash
curl http://localhost:5080/api/sinhvien
```

API trả các trường `id`, `maSinhVien`, `hoTen`, `ngaySinh`, `gioiTinh`, `email`, `soDienThoai`, `lop`, `diaChi`. Trong Flutter, nút làm mới hoặc kéo danh sách xuống sẽ gọi lại API.

HTTP và `usesCleartextTraffic` chỉ dùng cho phát triển/bài tập. Ứng dụng phát hành nên dùng HTTPS.
