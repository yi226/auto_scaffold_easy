import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Counter: $value"),
        FilledButton(
          child: const Icon(Icons.add),
          onPressed: () => setState(() {
            value++;
          }),
        )
      ],
    );
  }
}
