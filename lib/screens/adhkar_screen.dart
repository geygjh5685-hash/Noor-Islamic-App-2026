import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/sample_data.dart';

class AdhkarScreen extends StatefulWidget {
  const AdhkarScreen({super.key});
  @override
  State<AdhkarScreen> createState() => _AdhkarScreenState();
}
class _AdhkarScreenState extends State<AdhkarScreen> {
  int count = 0;
  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('tasbih_count', count);
  }
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((p) => setState(() => count = p.getInt('tasbih_count') ?? 0));
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('الأذكار والمسبحة')),
    body: ListView(padding: const EdgeInsets.all(14), children: [
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        const Text('المسبحة الإلكترونية', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text('$count', style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        FilledButton.icon(onPressed: () { setState(() => count++); _save(); }, icon: const Icon(Icons.add), label: const Text('تسبيحة')),
        TextButton(onPressed: () { setState(() => count = 0); _save(); }, child: const Text('إعادة التصفير')),
      ]))),
      const SizedBox(height: 12),
      ...SampleData.adhkar.map((z) => Card(
        child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(z['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 8), Text(z['text']!, style: const TextStyle(fontSize: 17, height: 1.8)),
        ])),
      )),
      const Text('تنبيه: أضيفت نصوص تجريبية مختصرة. يجب مراجعة الأذكار وتوثيق مصادرها قبل النشر.', style: TextStyle(color: Colors.orange)),
    ]),
  );
}
