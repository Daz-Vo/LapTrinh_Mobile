import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Nền màu xám nhạt theo Figma
        fontFamily: 'Inter', // Hoặc font mặc định nếu chưa cài
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền ngoài cùng của trình duyệt web
      body: SafeArea(
        child: Center(
          child: Container(
            width: 390, // Fix cứng chiều rộng 390px theo Figma
            margin: const EdgeInsets.symmetric(vertical: 20), // Cách viền trên dưới một chút cho đẹp trên web
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC), // Nền bên trong app
              borderRadius: BorderRadius.circular(44), // Bo góc 44px
              border: Border.all(
                color: const Color(0xFFCBD5E1), // Màu viền
                width: 3, // Độ dày 3px
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(41), // Cắt phần nội dung bị tràn ra ngoài góc bo
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 1. TopBar
                    _buildTopBar(),
                    const SizedBox(height: 24),
                    // 2. Profile Header
                    _buildProfileHeader(),
                    const SizedBox(height: 24),
                    // 3. Stats Card
                    _buildStatsCard(),
                    const SizedBox(height: 32),
                    // 4. About Me
                    _buildAboutMe(),
                    const SizedBox(height: 24),
                    // 5. Skills & Expertise
                    _buildSkills(),
                    const SizedBox(height: 24),
                    // 6. Featured Projects
                    _buildFeaturedProjects(),
                    const SizedBox(height: 24),
                    // 7. Contact Card
                    _buildContactCard(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(Icons.arrow_back_ios_new, size: 18),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          _buildIconButton(Icons.share_outlined, size: 20),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {double size = 24}) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Icon(icon, size: size, color: const Color(0xFF0F172A)),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          // Avatar Stack
          SizedBox(
            width: 140,
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Gradient Ring (140x140)
                Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFB087),
                        Color(0xFFFF8080),
                        Color(0xFFFFCF70),
                      ],
                      stops: [0.0, 0.3571, 0.7143],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // White Border (132x132)
                Container(
                  width: 132,
                  height: 132,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                // Avatar Image (124x124)
                ClipOval(
                  child: Image.asset(
                    'images/Avatar.png',
                    width: 124,
                    height: 124,
                    fit: BoxFit.cover,
                  ),
                ),
                // Verified Badge (28x28)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0284C7),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Name
          const Text(
            'Alex Rivers',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          // Role
          const Text(
            'Lead Mobile Engineer',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),
          // Location Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF475569)),
                SizedBox(width: 4),
                Text(
                  'Tokyo, Japan',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('148', 'Projects'),
          _buildVerticalDivider(),
          _buildStatItem('9 Yrs', 'Experience'),
          _buildVerticalDivider(),
          _buildStatItem('4.9 ★', 'Rating', isRating: true),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 28,
      color: const Color(0xFFE2E8F0),
    );
  }

  Widget _buildStatItem(String value, String label, {bool isRating = false}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20, // Kích thước 20px theo Figma
            fontWeight: FontWeight.w700, // Đậm 700
            color: isRating ? const Color(0xFFEAB308) : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutMe() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Passionate Lead Mobile Engineer specialized in Flutter, Dart, and building high-performance cross-platform applications. Focused on elegant user experiences.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkills() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skills & Expertise',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSkillChip('Flutter', Icons.flutter_dash, const Color(0xFFE0F2FE), const Color(0xFF0369A1)),
              _buildSkillChip('Dart', Icons.code, const Color(0xFFDCFCE7), const Color(0xFF15803D)),
              _buildSkillChip('Clean Arch', Icons.architecture, const Color(0xFFFFE4E6), const Color(0xFFBE123C)),
              _buildSkillChip('UI/UX', Icons.design_services, const Color(0xFFF3E8FF), const Color(0xFF7E22CE)),
              _buildSkillChip('Firebase', Icons.local_fire_department, const Color(0xFFFEF3C7), const Color(0xFFB45309)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label, IconData icon, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600, // Đậm 600 (SemiBold) theo Figma
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProjects() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Projects',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildProjectCard(
                  'E-Shop Flutter',
                  'Mobile App • 2026',
                  'images/Anh1.png',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProjectCard(
                  'Crypto Vault',
                  'Finance • Clean Arch',
                  'images/Anh2.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String subtitle, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildContactRow(null, 'Contact Information', isBold: true, leadingText: '@'),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _buildContactRow(Icons.email_outlined, 'alex.rivers@email.com'),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _buildContactRow(Icons.phone_outlined, '+81 (90) 1234-5678'),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData? icon, String text, {bool isBold = false, String? leadingText}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (leadingText != null)
            Text(
              leadingText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
            )
          else if (icon != null)
            Icon(icon, size: 20, color: const Color(0xFF64748B)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          const Icon(Icons.chevron_right, size: 20, color: Color(0xFFCBD5E1)),
        ],
      ),
    );
  }
}
