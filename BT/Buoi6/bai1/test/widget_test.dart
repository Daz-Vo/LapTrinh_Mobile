// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:buoi6/main.dart';

void main() {
  test('Student parses API fields', () {
    final student = Student.fromJson({
      'id': 7,
      'maSinhVien': 'SV007',
      'hoTen': 'Đặng Tuấn Kiệt',
      'ngaySinh': '2004-02-08T00:00:00+00:00',
      'gioiTinh': 'Nam',
      'email': 'kiet@example.com',
      'soDienThoai': '0901000007',
      'lop': 'DH23B',
      'diaChi': 'Bình Phước',
    });

    expect(student.id, 7);
    expect(student.studentCode, 'SV007');
    expect(student.fullName, 'Đặng Tuấn Kiệt');
    expect(student.className, 'DH23B');
    expect(student.phone, '0901000007');
  });
}
