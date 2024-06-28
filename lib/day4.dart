
import 'package:day5/custom_scroll.dart';
import 'package:day5/tabs/tab2.dart';
import 'package:day5/tabs/tab3.dart';
import 'package:day5/tabs/tab4.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Assesment 4',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.purple,
          toolbarHeight: 100,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const Text(
                    'Assessment 4',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>const Custom_scroll(),
                            ));
                      },
                      child: const Icon(Icons.add_link_outlined))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const TabBar(
                automaticIndicatorColorAdjustment: true,
                tabs: [
                  Tab(
                    
                    text: 'Day 2 Tab',
                  ),
                  Tab(
                    text: 'Day 3 Tab',
                  ),
                  Tab(
                    text: 'Day 4 Tab',
                  )
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Tabs2(),
            Tabs3(),
            Tabs4(),
          ],
        ),
      ),
    );
  }
}
