import 'package:auto_scaffold_easy/auto_scaffold_easy.dart';
import 'package:flutter/material.dart';

import 'test_widget.dart';

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
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const AutoScaffold(
      saveState: true,
      tabPages: [
        TabItem(
          label: "Home",
          icon: Icon(Icons.home),
          selectedIcon: Icon(Icons.home_outlined),
          widget: Home(key: ValueKey("Home")),
        ),
        TabItem(
          label: "Star",
          icon: Icon(Icons.star),
          selectedIcon: Icon(Icons.star_border),
          widget: Home(key: ValueKey("Star")),
        ),
      ],
    );
  }
}
