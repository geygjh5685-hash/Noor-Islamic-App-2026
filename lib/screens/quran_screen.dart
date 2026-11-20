import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/quran_metadata.dart';

class _QuranSurah {
  final int number;
  final String name;
  final List<String> verses;

  const _QuranSurah({
    required this.number,
    required this.name,
    required this.verses,
  });
}

Future<List<_QuranSurah>> _loadSurahs() async {
  final raw = await rootBundle.loadString(
    'assets/data/quran-uthmani.txt',
  );

  final verses = <String>[];

  for (final sourceLine in raw.split('\n')) {
    final line = sourceLine.endsWith('\r')
        ? sourceLine.substring(0, sourceLine.length - 1)
        : sourceLine;

    if (line.trim().isEmpty || line.startsWith('#')) {
      continue;
    }

    verses.add(line);
  }

  if (verses.length != 6236) {
    throw FormatException(
      'عدد الآيات غير صحيح: ${verses.length}',
    );
  }

  if (QuranMetadata.surahNames.length != 114 ||
      QuranMetadata.ayahCounts.length != 114) {
    throw const FormatException('بيانات السور غير مكتملة');
  }

  final surahs = <_QuranSurah>[];
  int offset = 0;

  for (int i = 0; i < 114; i++) {
    final count = QuranMetadata.ayahCounts[i];

    surahs.add(
      _QuranSurah(
        number: i + 1,
        name: QuranMetadata.surahNames[i],
        verses: verses.sublist(offset, offset + count),
      ),
    );

    offset += count;
  }

  if (offset != verses.length) {
    throw const FormatException('لم تتطابق بيانات الآيات');
  }

  return surahs;
}

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late final Future<List<_QuranSurah>> _surahsFuture;
  late Future<int?> _lastSurahFuture;

  @override
  void initState() {
    super.initState();
 _surahsFuture = _loadSurahs();
 _lastSurahFuture =
 _loadLastSurahNumber();
  }
 Future<int?> _loadLastSurahNumber() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('last_surah');
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<_QuranSurah>>(
        future: _surahsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'تعذر تحميل المصحف:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          final surahs = snapshot.data!;

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(12),
                child: const ListTile(
                  leading: Icon(
                    Icons.menu_book,
                    size: 35,
                    color: Colors.green,
                  ),
                  title: Text(
                    'مصحف نور الإسلامي',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('114 سورة • 6236 آية'),
                ),
              ),
FutureBuilder<int?>(
future: _lastSurahFuture,
  builder: (context, lastSnapshot) {
    final lastNumber = lastSnapshot.data;

    if (lastNumber == null) {
      return const SizedBox.shrink();
    }

    final matchingSurahs =
        surahs.where((s) => s.number == lastNumber).toList();

    if (matchingSurahs.isEmpty) {
      return const SizedBox.shrink();
    }

    final lastSurah = matchingSurahs.first;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'متابعة القراءة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('سورة ${lastSurah.name}'),
        trailing: const Icon(Icons.chevron_left),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SurahReaderScreen(
                surah: lastSurah,
              ),
            ),
          );
        },
      ),
    );
  },
),
             const Padding(
             padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'سور القرآن الكريم',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: surahs.length,
                  itemBuilder: (context, index) {
                    final surah = surahs[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${surah.number}'),
                        ),
                        title: Text(
                          surah.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        subtitle: Text(
                          '${surah.verses.length} آية',
                        ),
                        trailing: const Icon(
                          Icons.chevron_left,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SurahReaderScreen(
                                surah: surah,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SurahReaderScreen extends StatefulWidget	{
  final _QuranSurah surah;

  const SurahReaderScreen({
    super.key,
    required this.surah,
  });

  @override
  State<SurahReaderScreen> createState() => _SurahReaderScreenState();
}

class _SurahReaderScreenState extends State<SurahReaderScreen> {
  _QuranSurah get surah => widget.surah;

final ScrollController _scrollController = ScrollController();
bool _restoringPosition = true;

@override
void initState() {
  super.initState();
  _restorePosition();
}

Future<void> _restorePosition() async {
  final prefs = await SharedPreferences.getInstance();
  final savedSurah = prefs.getInt('last_surah');
  final savedOffset = prefs.getDouble('last_offset') ?? 0.0;

  if (savedSurah == surah.number) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_scrollController.hasClients) {
        final max = _scrollController.position.maxScrollExtent;
        _scrollController.jumpTo(
          savedOffset.clamp(0.0, max).toDouble(),
        );
      }
      _restoringPosition = false;
    });
  } else {
    await prefs.setInt('last_surah', surah.number);
    await prefs.setDouble('last_offset', 0.0);
    _restoringPosition = false;
  }
}  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سورة ${surah.name}'),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          if (!_restoringPosition && _scrollController.hasClients) {
            SharedPreferences.getInstance().then((prefs) async {
              await prefs.setInt('last_surah', surah.number);
              await prefs.setDouble(
                'last_offset',
                _scrollController.offset,
              );
            });
          }
          return false;
        },
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          Center(
            child: Text(
              'سورة ${surah.name}',
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '${surah.verses.length} آية',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const Divider(height: 32),
          ...List.generate(surah.verses.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        surah.verses[index],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 24,
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 15,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 30),
        ],
      ),
      ),
    );
  }
}
