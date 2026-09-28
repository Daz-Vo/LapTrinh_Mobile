import 'dart:async';

/// Trả về một Stream<int> mô phỏng tiến trình tải từ 0 -> 100.
/// Mỗi bước tăng theo `step` (mặc định 5) và chờ `delay` (mặc định 1s).
Stream<int> simulateDownload({
  int step = 5,
  Duration delay = const Duration(seconds: 1),
}) async* {
  for (int progress = 0; progress <= 100; progress += step) {
    yield progress;
    if (progress < 100) {
      await Future.delayed(delay);
    }
  }
}

Future<void> main() async {
  // Lắng nghe luồng bất đồng bộ và in ra tiến trình ngay khi nhận giá trị mới
  await for (final p in simulateDownload()) {
    print('Tiến độ: ${p}%');
  }
  print('Tải hoàn tất.');
}