import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('القرآن الكريم')),
    body: ListView(padding: const EdgeInsets.all(12), children: [
      Card(child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.bookmark_outline)),
        title: const Text('متابعة القراءة'),
        subtitle: const Text('لم تبدأ جلسة قراءة بعد'),
        trailing: const Icon(Icons.chevron_left),
      )),
      const Padding(padding: EdgeInsets.all(12), child: Text('السور', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      ...SampleData.surahs.map((s) => Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${SampleData.surahs.indexOf(s)+1}')),
          title: Text(s['name']!),
          subtitle: Text('${s['count']} • ${s['meaning']}'),
          trailing: const Icon(Icons.chevron_left),
          onTap: () => showDialog(context: context, builder: (_) => AlertDialog(
            title: Text('سورة ${s['name']}'),
            content: const Text('سيتم عرض نص المصحف بالرسم العثماني هنا بعد إضافة قاعدة بيانات قرآنية موثوقة ومراجعة.'),
            actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('حسناً'))],
          )),
        ),
      )),
      const Padding(padding: EdgeInsets.all(12), child: Text('هذه قائمة أولية للتجربة؛ لا تتضمن حالياً النص القرآني الكامل.', style: TextStyle(color: Colors.orange))),
    ]),
  );
}
