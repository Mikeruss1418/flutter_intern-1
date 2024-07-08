import 'package:day5/dashboard.dart';
import 'package:day5/login.dart';
import 'package:day5/signup.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedindex = 0;
  final pages = [
    const SignUp(),
    const Login(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      body: pages[selectedindex],
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback:
                    false, //provides the longpress vibration and sounds
                onPressed: () {
                  setState(() {
                    selectedindex = 0;
                  });
                },
                icon: selectedindex == 0
                    ? const Icon(Icons.home_filled)
                    : const Icon(Icons.home),
                tooltip: 'Sign UP',
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedindex = 1;
                    Login();
                  });
                },
                icon: selectedindex == 1
                    ? const Icon(Icons.login)
                    : const Icon(Icons.login_outlined),
                tooltip: 'Login',
              ),
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       selectedindex = 2;
              //     });
              //   },
              //   icon: selectedindex == 2
              //       ? const Icon(Icons.dashboard)
              //       : const Icon(Icons.dashboard_outlined),
              //   tooltip: 'Dashboard',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
