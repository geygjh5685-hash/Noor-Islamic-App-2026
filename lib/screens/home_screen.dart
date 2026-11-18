import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return CustomScrollView(slivers: [
      SliverAppBar.large(
        title: const Text('نور الإسلامي', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none))],
      ),
      SliverToBoxAdapter(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity, padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withValues(alpha: .72)]),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.nightlight_round, color: Colors.amber, size: 34),
              SizedBox(height: 12),
              Text('السلام عليكم ورحمة الله', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('اجعل يومك عامراً بالذكر والقرآن', style: TextStyle(color: Colors.white70)),
            ]),
          ),
          const SizedBox(height: 22),
          const Text('مواقيت الصلاة', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _Prayer(name:'الفجر',time:'—'), _Prayer(name:'الظهر',time:'—'),
              _Prayer(name:'العصر',time:'—'), _Prayer(name:'المغرب',time:'—'),
              _Prayer(name:'العشاء',time:'—'),
            ],
          ))),
          const SizedBox(height: 22),
          const Text('وصول سريع', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2.5,
            children: const [
              _Quick(icon:Icons.menu_book,title:'القرآن الكريم'),
              _Quick(icon:Icons.favorite,title:'الأذكار اليومية'),
              _Quick(icon:Icons.extension,title:'الألعاب والمسابقات'),
              _Quick(icon:Icons.auto_stories,title:'المكتبة الإسلامية'),
            ],
          ),
          const SizedBox(height: 18),
          Card(child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.lightbulb_outline)),
            title: const Text('ميزة قادمة: المساعد الإسلامي الذكي'),
            subtitle: const Text('إجابات موثقة من مصادر معتمدة، بعد ربط خدمة الذكاء الاصطناعي.'),
          )),
          const SizedBox(height: 24),
          const Center(child: Text('نورٌ يرافقك في كل لحظة', style: TextStyle(color: Colors.grey))),
        ]),
      )),
    ]);
  }
}

class _Prayer extends StatelessWidget {
  final String name, time;
  const _Prayer({required this.name, required this.time});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
    const SizedBox(height: 5), Text(time, style: const TextStyle(color: Colors.grey)),
  ]);
}
class _Quick extends StatelessWidget {
  final IconData icon; final String title;
  const _Quick({required this.icon, required this.title});
  @override
  Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(children: [Icon(icon, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 8), Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)))]),
  ));
}
