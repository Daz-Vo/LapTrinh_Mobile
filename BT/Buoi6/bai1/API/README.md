# Student API

Backend ASP.NET Core Web API đọc danh sách sinh viên từ SQL Server, database `LapTrinhMobile`, bảng `dbo.SinhVien`.

## Yêu cầu

- Garuda Linux / Arch Linux
- .NET 10 SDK và ASP.NET Core runtime
- SQL Server có thể truy cập từ máy đang chạy API
- Database `LapTrinhMobile` đã có bảng `dbo.SinhVien` và dữ liệu

## Cài .NET SDK

```bash
sudo pacman -Syu dotnet-sdk aspnet-runtime
dotnet --version
```

## Cấu hình kết nối database

Backend đọc khóa `ConnectionStrings:StudentDb` từ `appsettings.json`. Cấu hình host SQL Server truy cập được từ Garuda, database `LapTrinhMobile`, tài khoản SQL Server và mật khẩu.

Không commit mật khẩu thật lên Git. Có thể dùng User Secrets thay cho mật khẩu trong `appsettings.json`:

```bash
dotnet user-secrets set 'ConnectionStrings:StudentDb' 'Server=YOUR_SQL_SERVER_HOST,1433;Database=LapTrinhMobile;User Id=sa;Password=YOUR_PASSWORD;Encrypt=True;TrustServerCertificate=True' --project BT/buoi6/API/StudentApi.csproj
```

Thay `YOUR_SQL_SERVER_HOST` và `YOUR_PASSWORD` bằng thông tin của bạn. Host như `sqlserver_db` chỉ phân giải được khi API chạy trong cùng mạng Docker với SQL Server. User Secrets sẽ ghi đè cấu hình cùng khóa trong `appsettings.json` khi chạy Development.

## Chạy backend

Từ workspace root, build project:

```bash
dotnet build BT/buoi6/API/StudentApi.csproj
```

Do workspace nằm dưới `/run/media`, apphost có thể bị filesystem chặn quyền thực thi. Chạy DLL từ đúng thư mục API để backend đọc được `appsettings.json`:

```bash
cd BT/buoi6/API
env ASPNETCORE_ENVIRONMENT=Development dotnet bin/Debug/net10.0/StudentApi.dll --urls http://0.0.0.0:5080
```

Giữ terminal backend mở trong lúc chạy Flutter.

### Kiểm tra API đang chạy hay đã tắt

Mở terminal khác và gọi endpoint:

```bash
curl -i --max-time 5 http://127.0.0.1:5080/api/sinhvien
```

- `HTTP/1.1 200 OK` và JSON sinh viên: API đang chạy, đồng thời truy vấn SQL Server thành công.
- `Connection refused` hoặc không kết nối được: không có API lắng nghe ở địa chỉ/cổng đó, hoặc API đã tắt.
- `HTTP 500`: API đang chạy nhưng xử lý yêu cầu bị lỗi; xem log ở terminal backend, thường cần kiểm tra kết nối database.

Cũng có thể kiểm tra cổng `5080` có tiến trình lắng nghe không:

```bash
ss -ltnp 'sport = :5080'
```

### Tắt API

Quay lại terminal đang chạy `StudentApi.dll` và nhấn `Ctrl+C`. Kestrel sẽ dừng; lệnh `curl` ở trên sau đó sẽ báo không kết nối được.

Nếu thấy `address already in use` khi khởi động, API cũ vẫn đang chiếm cổng `5080`. Không cần khởi động thêm bản thứ hai: dùng terminal của tiến trình cũ và nhấn `Ctrl+C`, hoặc kiểm tra tiến trình đang nghe bằng `ss` trước.

## Chạy Flutter

Mở terminal thứ hai tại workspace root:

```bash
cd BT/buoi6
flutter pub get
flutter run
```

Android Emulator mặc định gọi `http://10.0.2.2:5080/api/sinhvien`; Flutter Linux gọi `http://127.0.0.1:5080/api/sinhvien`.

Khi chạy trên điện thoại Android thật, truyền IP LAN của máy tính đang chạy backend:

```bash
flutter run --dart-define=STUDENT_API_URL=http://YOUR_COMPUTER_IP:5080/api/sinhvien
```

Thay `YOUR_COMPUTER_IP` bằng IP LAN của máy tính. Điện thoại và máy tính cần cùng mạng Wi-Fi, và firewall cần cho phép cổng `5080`.

Nếu build APK báo không đủ quyền chạy `android/gradlew`, hãy build từ filesystem Linux như thư mục home. Ổ removable hiện tại không giữ quyền execute của Gradle wrapper.

## Xem API

- Danh sách sinh viên: <http://localhost:5080/api/sinhvien>
- Tài liệu OpenAPI dạng JSON: <http://localhost:5080/openapi/v1.json>

Endpoint danh sách dùng phương thức `GET` và trả về các trường như `id`, `maSinhVien`, `hoTen`, `ngaySinh`, `gioiTinh`, `email`, `soDienThoai`, `lop`, `diaChi`.

Có thể gửi request từ terminal:

```bash
curl http://localhost:5080/api/sinhvien
```

Hoặc mở file `StudentApi.http` trong VS Code để gửi request mẫu.

HTTP và `usesCleartextTraffic` chỉ phù hợp môi trường bài tập/phát triển; ứng dụng phát hành nên dùng HTTPS.

## Một số lỗi thường gặp

- **Thiếu connection string:** chạy lại lệnh `dotnet user-secrets set` từ đúng thư mục gốc workspace.
- **Không phân giải được `sqlserver_db`:** đổi sang IP hoặc hostname SQL Server truy cập được từ máy Garuda; tên service Docker không tự phân giải từ host.
- **Không kết nối được SQL Server:** kiểm tra SQL Server đang chạy, cổng `1433` được mở và tài khoản có quyền đọc bảng.
- **Không tìm thấy bảng/cột:** kiểm tra database là `LapTrinhMobile` và schema bảng khớp với `dbo.SinhVien`.