import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> fetchApiData() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return response.body;
  }

  throw Exception('Tải dữ liệu thất bại!');
}

Map<String, dynamic> parseData(String responseBody) {
  return jsonDecode(responseBody) as Map<String, dynamic>;
}

Stream<int> countDown() async* {
  for (int number = 5; number >= 1; number--) {
    await Future.delayed(const Duration(seconds: 1));
    yield number;
  }
}

Future<void> main() async {
  try {
    final responseBody = await fetchApiData();
    final dataMap = parseData(responseBody);

    print('Tiêu đề: ${dataMap['title']}');
    print('Nội dung: ${dataMap['body']}');
  } catch (error) {
    print('Lỗi: $error');
  }

  print('Chuẩn bị đếm ngược...');
  await for (final number in countDown()) {
    print(number);
  }
  print('Kết thúc!');
}
