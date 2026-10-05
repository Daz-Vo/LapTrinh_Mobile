import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SongDetailScreen(),
    ),
  );
}

class SongDetailScreen extends StatelessWidget {
  const SongDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SongHero(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SongInfoRow(
                            icon: Icons.person,
                            label: 'Ca sĩ',
                            value: 'Sơn Tùng M-TP',
                          ),
                          SizedBox(height: 9),
                          _SongInfoRow(
                            icon: Icons.album,
                            label: 'Album',
                            value: ' single',
                          ),
                          SizedBox(height: 9),
                          _SongInfoRow(
                            icon: Icons.schedule,
                            label: 'Thời lượng',
                            value: '4:12',
                          ),
                          SizedBox(height: 9),
                          _SongInfoRow(
                            icon: Icons.category,
                            label: 'Thể loại',
                            value: 'V-Pop',
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Mô tả',
                            style: TextStyle(
                              color: Color(0xFF242936),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8),
                          _DescriptionBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
              child: Container(
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF2589E8),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x332589E8),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 19),
                    SizedBox(width: 5),
                    Text(
                      'Phát nhạc',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SongHero extends StatelessWidget {
  const _SongHero();

  static const _coverAsset = 'assets/images/noi_nay_co_anh.jpg';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 224,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            _coverAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFF4B647A),
              alignment: Alignment.center,
              child: const Icon(
                Icons.music_note,
                color: Colors.white70,
                size: 64,
              ),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x22000000), Color(0xCC000000)],
              ),
            ),
          ),
          const Positioned(
            top: 14,
            left: 16,
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 19),
          ),
          const Positioned(
            left: 18,
            right: 18,
            bottom: 16,
            child: Text(
              'Nơi này có anh',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SongInfoRow extends StatelessWidget {
  const _SongInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 31,
          height: 31,
          decoration: BoxDecoration(
            color: const Color(0xFFE3F1FF),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFF2589E8), size: 17),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF898D98),
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF2D3039),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DescriptionBox extends StatelessWidget {
  const _DescriptionBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE3E5EA)),
      ),
      child: const Text(
        'Một bài hát nhẹ nhàng, lãng mạn với giai điệu bắt tai và lời ca sâu lắng về tình yêu.',
        style: TextStyle(
          color: Color(0xFF555965),
          fontSize: 12,
          height: 1.45,
        ),
      ),
    );
  }
}