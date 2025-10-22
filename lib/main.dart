import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'comic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XKCD Comics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'XKCD Programming Comics'),
    );
  }
}

/// On web, route through a simple CORS passthrough; elsewhere use the raw URL.
String _img(String url) {
  if (!kIsWeb) return url;
  return 'https://corsproxy.io/?${Uri.encodeFull(url)}';
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Comic> xkcdComics = [];

  _MyHomePageState() {
    xkcdComics.add(Comic(303,  "https://imgs.xkcd.com/comics/compiling.png",             "Compiling"));
    xkcdComics.add(Comic(323,  "https://imgs.xkcd.com/comics/ballmer_peak.png",          "Ballmer Peak"));
    xkcdComics.add(Comic(353,  "https://imgs.xkcd.com/comics/python.png",                "Python"));
    xkcdComics.add(Comic(1513, "https://imgs.xkcd.com/comics/code_quality.png",          "Code Quality"));
    xkcdComics.add(Comic(1667, "https://imgs.xkcd.com/comics/algorithms.png",            "Algorithms"));
    xkcdComics.add(Comic(1205, "https://imgs.xkcd.com/comics/is_it_worth_the_time.png",  "Is It Worth the Time?"));
    xkcdComics.add(Comic(2021, "https://imgs.xkcd.com/comics/software_development.png",  "Software Development"));
    xkcdComics.add(Comic(844,  "https://imgs.xkcd.com/comics/good_code.png",             "Good Code"));
    xkcdComics.add(Comic(1172, "https://imgs.xkcd.com/comics/workflow.png",              "Workflow"));
    xkcdComics.add(Comic(1823, "https://imgs.xkcd.com/comics/hacking.png",               "Hacking"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: xkcdComics.length,
        itemBuilder: (BuildContext context, int index) {
          final comic = xkcdComics[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _img(comic.img),
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  loadingBuilder: (c, w, p) => const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                  errorBuilder: (c, e, s) => const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
              title: Text(comic.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text("Comic #${comic.num}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ComicViewerPage(comic: comic)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ComicViewerPage extends StatelessWidget {
  final Comic comic;
  const ComicViewerPage({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("#${comic.num} • ${comic.title}")),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 5,
          child: Image.network(
            _img(comic.img),
            fit: BoxFit.contain,
            loadingBuilder: (c, w, progress) {
              if (progress == null) return w;
              final value = progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes!)
                  : null;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 36, height: 36,
                    child: CircularProgressIndicator(value: value),
                  ),
                  const SizedBox(height: 12),
                  const Text("Loading image…"),
                ],
              );
            },
            errorBuilder: (c, e, s) => const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, size: 48),
                  SizedBox(height: 12),
                  Text("Couldn’t load this comic."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
