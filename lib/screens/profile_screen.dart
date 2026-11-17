import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import 'certificate_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: CachedNetworkImageProvider(
                      user.avatarUrl,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    '${user.coursesEnrolled}',
                    'Enrolled',
                    Icons.play_circle_outline_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    '${user.certificates}',
                    'Certificates',
                    Icons.workspace_premium_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text(
              'My Certificates',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            ...MockData.certificates.map(
                  (cert) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.workspace_premium_rounded,
                      color: AppColors.primary),
                ),
                title: Text(
                  cert.courseTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Issued ${cert.issuedDate.year}',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing:
                const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CertificateScreen(certificate: cert),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _menuTile(Icons.settings_outlined, 'Settings'),
            _menuTile(Icons.help_outline_rounded, 'Help & Support'),
            _menuTile(Icons.logout_rounded, 'Log Out'),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String label) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.textDark),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}