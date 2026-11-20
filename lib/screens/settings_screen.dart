
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  final bool darkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.darkMode,
    required this.onThemeChanged,
  });

  Future<void> _openContact(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _callDeveloper() async {
    await _openContact('tel:+967737295689');
  }

  Future<void> _openWhatsApp() async {
    await _openContact('https://wa.me/967737295689');
  }

  Future<void> _sendEmail() async {
    await _openContact(
      'mailto:geygjh5685@gmail.com?subject=تواصل%20مع%20مطور%20نور%20الإسلامي',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: darkMode,
            onChanged: onThemeChanged,
            title: const Text('الوضع الداكن'),
            subtitle: const Text(
              'التبديل بين المظهر الداكن والفاتح',
            ),
            secondary: const Icon(Icons.dark_mode_outlined),
          ),

          const Divider(height: 28),

          const ListTile(
            leading: Icon(Icons.language),
            title: Text('اللغة'),
            subtitle: Text('العربية حالياً'),
          ),

          const ListTile(
            leading: Icon(Icons.offline_pin_outlined),
            title: Text('المحتوى دون إنترنت'),
            subtitle: Text(
              'البيانات المحلية متاحة؛ التنزيلات ستضاف لاحقاً',
            ),
          ),

          const ListTile(
            leading: Icon(Icons.shield_outlined),
            title: Text('الخصوصية والأمان'),
            subtitle: Text(
              'لا تضع مفاتيح API داخل التطبيق',
            ),
          ),

          const SizedBox(height: 18),

          Center(
            child: Text(
              'عن المطور',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 3,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF063D35),
                        Color(0xFF08785D),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 78,
                        height: 78,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFD6B45C),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 43,
                          color: Color(0xFF063D35),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'حسن العباسي',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'المطور الرسمي لتطبيق نور الإسلامي',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6B45C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'نورٌ يرافقك في كل لحظة',
                          style: TextStyle(
                            color: Color(0xFF063D35),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: colors.primary,
                        ),
                        title: const Text('الهاتف وواتساب'),
                        subtitle: const SelectableText(
                          '+967 737295689',
                        ),
                      ),

                      const Divider(),

                      ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          color: colors.primary,
                        ),
                        title: const Text('البريد الإلكتروني'),
                        subtitle: const SelectableText(
                          'geygjh5685@gmail.com',
                        ),
                      ),

                      const Divider(),

                      const ListTile(
                        leading: Icon(
                          Icons.verified_user_outlined,
                          color: Color(0xFFC5A34D),
                        ),
                        title: Text('حقوق التطوير'),
                        subtitle: Text(
                          'جميع الحقوق محفوظة لمطور نور الإسلامي',
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _callDeveloper,
                          icon: const Icon(Icons.call),
                          label: const Text('اتصل بالمطور'),
                        ),
                      ),

                      const SizedBox(height: 8),

                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _openWhatsApp,
                          icon: const Icon(Icons.chat),
                          label: const Text('تواصل عبر واتساب'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF16865B),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _sendEmail,
                          icon: const Icon(Icons.email_outlined),
                          label: const Text('إرسال بريد إلكتروني'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          const AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationName: 'نور الإسلامي',
            applicationVersion: '1.0.0',
            applicationLegalese: 'نورٌ يرافقك في كل لحظة',
          ),
        ],
      ),
    );
  }
}
