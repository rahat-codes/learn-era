import 'package:flutter/material.dart';
import '../models/certificate.dart';
import '../theme/app_theme.dart';

class CertificateScreen extends StatelessWidget {
  final Certificate certificate;

  const CertificateScreen({super.key, required this.certificate});

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${certificate.issuedDate.day} ${_month(certificate.issuedDate.month)} ${certificate.issuedDate.year}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate'),
        actions: [
          IconButton(
            onPressed: () => _showDownloadSnack(context),
            icon: const Icon(Icons.download_rounded),
          ),
          IconButton(
            onPressed: () => _showShareSheet(context),
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // --- Certificate card ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1B4DB1), Color(0xFF0D2E6E)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 2),
                    ),
                    child: const Icon(Icons.workspace_premium_rounded,
                        color: Colors.amber, size: 40),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'CERTIFICATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4,
                      fontSize: 13,
                    ),
                  ),
                  const Text(
                    'OF COMPLETION',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'This certificate is proudly presented to',
                    style:
                    TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    certificate.studentName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'for successfully completing',
                    style:
                    TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    certificate.courseTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Instructor: ${certificate.instructor}',
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _footerBlock('DATE', dateStr),
                      _footerBlock('GRADE',
                          '${certificate.grade.toStringAsFixed(1)}%'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Icons.verified_rounded,
                          size: 14, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        'Certificate #${certificate.certificateNumber}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // --- Actions ---
            _actionTile(
              icon: Icons.download_rounded,
              title: 'Download PDF',
              subtitle: 'Save a copy to your device',
              onTap: () => _showDownloadSnack(context),
            ),
            _actionTile(
              icon: Icons.share_rounded,
              title: 'Share Certificate',
              subtitle: 'Share on LinkedIn or with friends',
              onTap: () => _showShareSheet(context),
            ),
            _actionTile(
              icon: Icons.qr_code_2_rounded,
              title: 'Verify Certificate',
              subtitle: 'Anyone can verify authenticity',
              onTap: () => _showVerifyDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _footerBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 10,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          color: AppColors.textGrey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }

  void _showDownloadSnack(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download started (mock)')),
    );
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Share Certificate',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _ShareOption(icon: Icons.link_rounded, label: 'Copy Link'),
                _ShareOption(
                    icon: Icons.work_rounded, label: 'LinkedIn'),
                _ShareOption(icon: Icons.email_rounded, label: 'Email'),
                _ShareOption(icon: Icons.more_horiz, label: 'More'),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showVerifyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Verify Certificate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.qr_code_2_rounded, size: 100),
            ),
            const SizedBox(height: 12),
            SelectableText(
              certificate.certificateNumber,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 13),
            ),
            const SizedBox(height: 4),
            const Text(
              'Scan the QR code or visit\nlearn_era.com/verify',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }

  static String _month(int m) {
    const names = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return names[m - 1];
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ShareOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}