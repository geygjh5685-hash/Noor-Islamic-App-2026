import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});
  static const items = [
    ('السيرة النبوية','محطات من حياة النبي ﷺ',Icons.history_edu),
    ('قصص الأنبياء','دروس وعبر من قصص الأنبياء',Icons.auto_stories),
    ('الحديث الشريف','مصادر الحديث وشروحه',Icons.menu_book),
    ('الفقه والعبادات','مواد تعليمية مبسطة',Icons.school),
    ('الأطفال','تعلم وقصص وأنشطة مناسبة للصغار',Icons.child_friendly),
    ('التقويم الإسلامي','المناسبات والأيام الهجرية',Icons.calendar_month),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('المكتبة الإسلامية')),
    body: ListView(padding: const EdgeInsets.all(12), children: [
      ...items.map((e) => Card(child: ListTile(
        leading: CircleAvatar(child: Icon(e.$3)),
        title: Text(e.$1), subtitle: Text(e.$2),
        trailing: const Icon(Icons.chevron_left),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('سيضاف المحتوى الموثق في مرحلة تجهيز المكتبة.'))),
      ))),
    ]),
  );
}
