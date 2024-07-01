import 'package:day5/day6.dart';
import 'package:day5/widgets/shared_statemanagemen.dart';
import 'package:flutter/material.dart';

class Cvresult extends StatefulWidget {
  const Cvresult({super.key});

  @override
  State<Cvresult> createState() => _CvresultState();
}

class _CvresultState extends State<Cvresult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Text(SharedState.fname.text),
      ),
    );
  }
}
