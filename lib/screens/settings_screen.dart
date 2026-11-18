import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  bool dark = false;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((p) => setState(() => dark = p.getBool('dark_mode') ?? false));
  }
  Future<void> toggle(bool v) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('dark_mode', v);
    setState(() => dark = v);
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الإعدادات')),
    body: ListView(children: [
      SwitchListTile(value: dark, onChanged: toggle, title: const Text('الوضع الليلي'), secondary: const Icon(Icons.dark_mode_outlined)),
      const ListTile(leading: Icon(Icons.language), title: Text('اللغة'), subtitle: Text('العربية حالياً')),
      const ListTile(leading: Icon(Icons.offline_pin_outlined), title: Text('المحتوى دون إنترنت'), subtitle: Text('البيانات المحلية متاحة؛ التنزيلات ستضاف لاحقاً')),
      const ListTile(leading: Icon(Icons.shield_outlined), title: Text('الخصوصية والأمان'), subtitle: Text('لا تدخل مفاتيح API داخل التطبيق')),
      const AboutListTile(icon: Icon(Icons.info_outline), applicationName: 'نور الإسلامي', applicationVersion: '1.0.0', applicationLegalese: 'نورٌ يرافقك في كل لحظة'),
    ]),
  );
}
