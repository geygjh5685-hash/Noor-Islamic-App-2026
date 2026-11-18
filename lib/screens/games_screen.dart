import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});
  @override
  State<GamesScreen> createState() => _GamesScreenState();
}
class _GamesScreenState extends State<GamesScreen> {
  int q = 0, score = 0;
  bool answered = false;
  void choose(int i) {
    if (answered) return;
    setState(() { answered = true; if (i == SampleData.quiz[q]['correct']) score++; });
  }
  void next() => setState(() { q = (q+1) % SampleData.quiz.length; answered = false; });
  @override
  Widget build(BuildContext context) {
    final item = SampleData.quiz[q];
    final answers = item['a'] as List<String>;
    return Scaffold(
      appBar: AppBar(title: const Text('الألعاب والمسابقات')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
          const Icon(Icons.emoji_events, size: 48, color: Colors.amber),
          const Text('تحدي المعلومات الإسلامية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('السؤال ${q+1} من ${SampleData.quiz.length} • نقاطك: $score'),
          const SizedBox(height: 18),
          Text(item['q'] as String, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
          const SizedBox(height: 14),
          ...List.generate(answers.length, (i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(width: double.infinity, child: OutlinedButton(
              onPressed: () => choose(i), child: Text(answers[i]),
            )),
          )),
          if (answered) ...[
            const SizedBox(height: 8),
            Text((item['correct'] as int) == (answers.indexOf(answers[(item['correct'] as int)])) ? 'تم تسجيل إجابتك.' : 'حاول مجدداً في السؤال القادم.'),
            FilledButton(onPressed: next, child: const Text('السؤال التالي')),
          ],
        ]))),
        const Text('المحتوى الحالي نموذج أولي، ويلزم تدقيق الأسئلة والإجابات قبل الإطلاق.', style: TextStyle(color: Colors.orange)),
      ]),
    );
  }
}
