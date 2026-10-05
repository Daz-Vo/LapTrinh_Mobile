# Hướng dẫn tạo và chạy dự án Flutter

## 1. Kiểm tra môi trường

Cài Flutter SDK và thêm lệnh `flutter` vào `PATH`. Mở Terminal, sau đó kiểm tra:

```bash
flutter --version
flutter doctor
```

Để chạy trên Android, cài Android Studio, Android SDK và khởi động Android Emulator hoặc kết nối điện thoại đã bật USB debugging. Để chạy trên web, cài Chrome.

## 2. Tạo dự án Flutter mới

Mở Terminal tại thư mục workspace `LapTrinh_Mobile`, rồi chạy:

```bash
cd /run/media/dazvo/FD45-091C/LapTrinh_Mobile
flutter create ten_du_an
cd ten_du_an
flutter pub get
```

Đổi `ten_du_an` thành tên dự án viết thường, có thể dùng dấu gạch dưới, ví dụ `ung_dung_moi`.

## 3. Chạy dự án `my_first_app` có sẵn

```bash
cd /run/media/dazvo/FD45-091C/LapTrinh_Mobile/my_first_app
flutter pub get
flutter devices
flutter run
```

Nếu có nhiều thiết bị, dùng ID hiển thị từ `flutter devices`:

```bash
flutter run -d <device-id>
```

Chạy trên Web:

```bash
flutter run -d web-server -t "Tên file"
```

Trong lúc ứng dụng đang chạy, nhấn `r` trong Terminal để hot reload hoặc `q` để dừng.

## 4. Kiểm tra dự án

```bash
flutter analyze
flutter test
```

Lưu ý: dự án hiện có khai báo ảnh `images/doraemon.png` trong `pubspec.yaml`; giữ ảnh tại đúng vị trí để ứng dụng tải asset thành công.