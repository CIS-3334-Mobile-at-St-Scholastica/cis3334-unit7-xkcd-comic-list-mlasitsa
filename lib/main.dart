import 'package:flutter/material.dart';
import 'comic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Comic> xkcdComics = [];

  _MyHomePageState() {
    xkcdComics.add( new Comic(844,"https://imgs.xkcd.com/comics/good_code.png","Good Code"));
    xkcdComics.add( new Comic(1513,"https://imgs.xkcd.com/comics/code_quality.png","Code Quality"));
    xkcdComics.add( new Comic(163,"https://imgs.xkcd.com/comics/donald_knuth.png","Donald Knuth"));
    xkcdComics.add( new Comic(2228,"https://imgs.xkcd.com/comics/machine_learning_captcha.png","Machine Learning Captcha"));
    xkcdComics.add( new Comic(1667,"https://imgs.xkcd.com/comics/algorithms.png","Algorithms"));
    // feel free to add your own comic from https://www.explainxkcd.com/wiki/index.php/Category:Programming
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text("Display list here"),
    );
  }
}