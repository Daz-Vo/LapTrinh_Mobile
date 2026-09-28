abstract class TaiLieu {
  String maSo;
  String tenNhaXuatBan;
  int soLuongPhatHanh;

  TaiLieu(this.maSo, this.tenNhaXuatBan, this.soLuongPhatHanh);

  void hienThiThongTin();
}

class Sach extends TaiLieu {
  String tenTacGia;
  int soTrang;

  Sach(String maSo, String tenNhaXuatBan, int soLuongPhatHanh, this.tenTacGia, this.soTrang)
      : super(maSo, tenNhaXuatBan, soLuongPhatHanh);

  @override
  void hienThiThongTin() {
    print('Sách - Mã số: $maSo, NXB: $tenNhaXuatBan, SL phát hành: $soLuongPhatHanh, Tác giả: $tenTacGia, Số trang: $soTrang');
  }
}

class TapChi extends TaiLieu {
  int soPhatHanh;
  int thangPhatHanh;

  TapChi(String maSo, String tenNhaXuatBan, int soLuongPhatHanh, this.soPhatHanh, this.thangPhatHanh)
      : super(maSo, tenNhaXuatBan, soLuongPhatHanh);

  @override
  void hienThiThongTin() {
    print('Tạp chí - Mã số: $maSo, NXB: $tenNhaXuatBan, SL phát hành: $soLuongPhatHanh, Số phát hành: $soPhatHanh, Tháng phát hành: $thangPhatHanh');
  }
}

class Bao extends TaiLieu {
  DateTime ngayPhatHanh;

  Bao(String maSo, String tenNhaXuatBan, int soLuongPhatHanh, this.ngayPhatHanh)
      : super(maSo, tenNhaXuatBan, soLuongPhatHanh);

  @override
  void hienThiThongTin() {
    print('Báo - Mã số: $maSo, NXB: $tenNhaXuatBan, SL phát hành: $soLuongPhatHanh, Ngày phát hành: ${ngayPhatHanh.day}/${ngayPhatHanh.month}/${ngayPhatHanh.year}');
  }
}

void main() {
  List<TaiLieu> danhSachTaiLieu = [
    Sach('S001', 'NXB Kim Đồng', 1000, 'Nguyễn Nhật Ánh', 250),
    TapChi('TC001', 'NXB Tuổi Trẻ', 500, 15, 9),
    Bao('B001', 'NXB Thanh Niên', 2000, DateTime(2023, 10, 20)),
  ];

  for (var taiLieu in danhSachTaiLieu) {
    taiLieu.hienThiThongTin();
  }
}
