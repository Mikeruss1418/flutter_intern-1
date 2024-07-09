// import 'dart:developer';

// import 'package:day5/widgets/splash.dart';
// import 'package:day5/home.dart';
import 'package:day5/practices/imagespicker.dart';
// import 'package:day5/signup.dart';
import 'package:day5/signup/home.dart';
// import 'package:day5/usercv_day6.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      home: HomePage(),
    );
  }
}
