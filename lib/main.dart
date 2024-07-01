// import 'dart:developer';

import 'package:day5/day6.dart';
// import 'package:day5/widgets/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ' CV Form',
      debugShowCheckedModeBanner: false,
      home: Day6(),
    );
  }
}
