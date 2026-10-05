import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const StudentApp());

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF126B68);
    return MaterialApp(
      title: 'Danh sách sinh viên',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: accent),
        scaffoldBackgroundColor: const Color(0xFFF3F7F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF3F7F6),
          foregroundColor: Color(0xFF183433),
          centerTitle: false,
        ),
        useMaterial3: true,
      ),
      home: const StudentListPage(),
    );
  }
}

class Student {
  const Student({
    required this.id,
    required this.studentCode,
    required this.fullName,
    this.dateOfBirth,
    this.gender,
    this.email,
    this.phone,
    this.className,
    this.address,
  });

  final int id;
  final String studentCode;
  final String fullName;
  final String? dateOfBirth;
  final String? gender;
  final String? email;
  final String? phone;
  final String? className;
  final String? address;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: (json['id'] as num).toInt(),
      studentCode: json['maSinhVien']?.toString() ?? '',
      fullName: json['hoTen']?.toString() ?? 'Chưa có họ tên',
      dateOfBirth: json['ngaySinh']?.toString(),
      gender: json['gioiTinh']?.toString(),
      email: json['email']?.toString(),
      phone: json['soDienThoai']?.toString(),
      className: json['lop']?.toString(),
      address: json['diaChi']?.toString(),
    );
  }
}

String get studentApiUrl {
  const override = String.fromEnvironment('STUDENT_API_URL');
  if (override.isNotEmpty) return override;
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.linux) {
    return 'http://127.0.0.1:5080/api/sinhvien';
  }
  if (defaultTargetPlatform == TargetPlatform.android) {
    return 'http://10.0.2.2:5080/api/sinhvien';
  }
  return 'http://127.0.0.1:5080/api/sinhvien';
}

Future<List<Student>> fetchStudents() async {
  final response = await http
      .get(Uri.parse(studentApiUrl), headers: {'Accept': 'application/json'})
      .timeout(const Duration(seconds: 15));

  if (response.statusCode != 200) {
    throw Exception('API trả về mã HTTP ${response.statusCode}.');
  }

  final decoded = jsonDecode(response.body);
  if (decoded is! List) {
    throw const FormatException('Dữ liệu API không phải danh sách sinh viên.');
  }

  return decoded.map((item) {
    if (item is! Map<String, dynamic>) {
      throw const FormatException('Một mục sinh viên có định dạng không hợp lệ.');
    }
    return Student.fromJson(item);
  }).toList(growable: false);
}

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late Future<List<Student>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = fetchStudents();
  }

  Future<void> _refreshStudents() async {
    final request = fetchStudents();
    setState(() => _studentsFuture = request);
    try {
      await request;
    } catch (_) {
      // FutureBuilder displays the error state.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách sinh viên',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Tải lại danh sách',
            onPressed: _refreshStudents,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<Student>>(
          future: _studentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const _LoadingView();
            }
            if (snapshot.hasError) {
              return _ErrorView(
                message: snapshot.error.toString(),
                onRetry: _refreshStudents,
              );
            }

            final students = snapshot.data ?? const <Student>[];
            if (students.isEmpty) return const _EmptyView();

            return RefreshIndicator(
              onRefresh: _refreshStudents,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  _ListHeading(count: students.length),
                  const SizedBox(height: 14),
                  for (final student in students) ...[
                    StudentTile(student: student),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListHeading extends StatelessWidget {
  const _ListHeading({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hồ sơ sinh viên',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 3),
                Text('Dữ liệu được tải từ máy chủ'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDCEFED),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$count sinh viên',
              style: const TextStyle(
                color: Color(0xFF125B58),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentTile extends StatelessWidget {
  const StudentTile({required this.student, super.key});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final name = student.fullName.trim();
    final initials = name.isEmpty ? '?' : name[0].toUpperCase();

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE0E9E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFDCEFED),
                  foregroundColor: const Color(0xFF125B58),
                  child: Text(
                    initials,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.fullName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        student.studentCode,
                        style: const TextStyle(color: Color(0xFF59706E)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (_hasValue(student.className))
                  _InfoTag(icon: Icons.class_outlined, label: student.className!),
                if (_hasValue(student.gender))
                  _InfoTag(icon: Icons.person_outline, label: student.gender!),
              ],
            ),
            if (_hasAnyDetail)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: Color(0xFFE8EFEE)),
              ),
            if (_hasValue(student.dateOfBirth))
              _StudentDetail(
                icon: Icons.calendar_today_outlined,
                text: _formatDate(student.dateOfBirth!),
              ),
            if (_hasValue(student.email))
              _StudentDetail(icon: Icons.mail_outline, text: student.email!),
            if (_hasValue(student.phone))
              _StudentDetail(icon: Icons.phone_outlined, text: student.phone!),
            if (_hasValue(student.address))
              _StudentDetail(
                icon: Icons.location_on_outlined,
                text: student.address!,
              ),
          ],
        ),
      ),
    );
  }

  bool get _hasAnyDetail =>
      _hasValue(student.dateOfBirth) ||
      _hasValue(student.email) ||
      _hasValue(student.phone) ||
      _hasValue(student.address);
}

class _InfoTag extends StatelessWidget {
  const _InfoTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F5F4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF496461)),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _StudentDetail extends StatelessWidget {
  const _StudentDetail({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF718481)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 14),
          Text('Đang tải danh sách sinh viên...'),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final displayMessage = message.startsWith('Exception: ')
        ? message.substring('Exception: '.length)
        : message;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 90),
        const Icon(Icons.cloud_off_outlined, size: 48, color: Color(0xFF9A5144)),
        const SizedBox(height: 14),
        const Text(
          'Không tải được dữ liệu',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(displayMessage, textAlign: TextAlign.center),
        const SizedBox(height: 18),
        Center(
          child: FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
          ),
        ),
      ],
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school_outlined, size: 44, color: Color(0xFF718481)),
          SizedBox(height: 12),
          Text('Chưa có sinh viên trong danh sách.'),
        ],
      ),
    );
  }
}

bool _hasValue(String? value) => value != null && value.trim().isNotEmpty;

String _formatDate(String value) {
  final date = DateTime.tryParse(value);
  if (date == null) return value;

  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}