import 'dart:io';

double tinhDiemTrungBinh(List<double> diem) {
  if (diem.isEmpty) return 0.0;
  double sum = 0;
  for (var d in diem) {
    sum += d;
  }
  return sum / diem.length;
}

String xepLoai(double dtb) {
  if (dtb >= 9.0) {
    return "Xuất sắc";
  } else if (dtb >= 8.0) {
    return "Giỏi";
  } else if (dtb >= 6.5) {
    return "Khá";
  } else if (dtb >= 5.0) {
    return "Trung bình";
  } else {
    return "Yếu";
  }
}

void main() {
  Map<String, double> diemMonHoc = {};
  List<String> monHoc = ['Toán', 'Văn', 'Anh'];

  for (var mon in monHoc) {
    while (true) {
      stdout.write('Nhập điểm môn $mon: ');
      String? input = stdin.readLineSync();
      if (input != null) {
        double? diem = double.tryParse(input);
        if (diem != null && diem >= 0 && diem <= 10) {
          diemMonHoc[mon] = diem;
          break;
        } else {
          print('Điểm không hợp lệ, vui lòng nhập lại bằng số từ 0 - 10.');
        }
      }
    }
  }

  List<double> diem = diemMonHoc.values.toList();
  double dtb = tinhDiemTrungBinh(diem);
  String loai = xepLoai(dtb);

  print("\nĐiểm trung bình: ${dtb.toStringAsFixed(2)}. Xếp loại: $loai");
}
