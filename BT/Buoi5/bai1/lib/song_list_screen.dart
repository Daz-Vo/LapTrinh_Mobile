import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SongListScreen(),
    ),
  );
}

class SongListScreen extends StatelessWidget {
  const SongListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F2F8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
              color: const Color(0xFF2589E8),
              child: const Text(
                'Danh sách bài hát',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(13, 7, 13, 16),
                itemCount: songs.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) => SongCard(song: songs[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Song {
  const Song({
    required this.title,
    required this.artist,
    required this.genre,
    required this.duration,
    required this.coverAsset,
  });

  final String title;
  final String artist;
  final String genre;
  final String duration;
  final String coverAsset;
}

const songs = <Song>[
  Song(
    title: 'Nơi này có anh',
    artist: 'Sơn Tùng M-TP',
    genre: 'V-Pop',
    duration: '4:12',
    coverAsset: 'assets/images/noi_nay_co_anh.jpg',
  ),
  Song(
    title: 'See Tình',
    artist: 'Hoàng Thùy Linh',
    genre: 'V-Pop',
    duration: '3:45',
    coverAsset: 'assets/images/see_tinh.jpg',
  ),
  Song(
    title: 'Hãy Trao Cho Anh',
    artist: 'Sơn Tùng M-TP',
    genre: 'V-Pop',
    duration: '3:38',
    coverAsset: 'assets/images/hay_trao_cho_anh.jpg',
  ),
  Song(
    title: 'Muốn',
    artist: 'Vũ Cát Tường',
    genre: 'Indie',
    duration: '4:01',
    coverAsset: 'assets/images/muon.jpg',
  ),
  Song(
    title: 'Đom Đóm',
    artist: 'Jack',
    genre: 'V-Pop',
    duration: '3:22',
    coverAsset: 'assets/images/dom_dom.jpg',
  ),
  Song(
    title: 'Bạc Phận',
    artist: 'Jack & K-ICM',
    genre: 'V-Pop',
    duration: '4:18',
    coverAsset: 'assets/images/bac_phan.jpg',
  ),
];

class SongCard extends StatelessWidget {
  const SongCard({required this.song, super.key});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 82),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FE),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _SongCover(assetPath: song.coverAsset),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF252936),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  song.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF858895),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD7EEFF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        song.genre,
                        style: const TextStyle(
                          color: Color(0xFF1881D2),
                          fontSize: 9,
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      song.duration,
                      style: const TextStyle(
                        color: Color(0xFF9699A3),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: Color(0xFFB7BAC3), size: 21),
        ],
      ),
    );
  }
}

class _SongCover extends StatelessWidget {
  const _SongCover({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Image.asset(
        assetPath,
        width: 61,
        height: 61,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 61,
          height: 61,
          color: const Color(0xFFDDE7F1),
          alignment: Alignment.center,
          child: const Icon(Icons.music_note, color: Color(0xFF68819A)),
        ),
      ),
    );
  }
}