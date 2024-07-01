import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tabs4 extends StatefulWidget {
  const Tabs4({super.key});

  @override
  State<Tabs4> createState() => _Tabs4State();
}

class _Tabs4State extends State<Tabs4> {
  bool show = true;
  List<dynamic> _gridValues = [];
  List<dynamic> _color = [];
  List<dynamic> image = [];
  List<dynamic> displaylist = [];
  List<dynamic> randomNum = [];
  List<dynamic> randomcolor = [];
  List<dynamic> randomimage = [];

  @override
  void initState() {
    super.initState();
    _gridValues = List.generate(
      20,
      (index) => {
        'title': 'This is ${index + 1}',
        'text': 'Num ${index + 1}',
      },
    );

    _color = [
      Colors.red,
      Colors.black87,
      Colors.amberAccent,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.deepOrange,
      Colors.amber,
      Colors.white,
      Colors.blue,
      Colors.blueGrey,
      Colors.brown,
      Colors.cyan,
      Colors.deepPurple,
      Colors.grey,
      Colors.indigo,
      Colors.lime,
      Colors.tealAccent,
      Colors.pink,
      Colors.lightBlue,
    ];

    image = [
      'https://images.unsplash.com/photo-1711972638202-e9585b245609?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D',
      'https://www.publicdomainpictures.net/pictures/170000/velka/landschaft-1463581037RbE.jpg',
      'https://images.unsplash.com/photo-1711816769781-0a8194f44399?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1711873315075-0a5cffd8c15a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Nnx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1711924847907-498771a92bde?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8fA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1687975124217-797c741d2a40?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8N3x8fGVufDB8fHx8fA%3D%3D',
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/206359/pexels-photo-206359.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/45853/grey-crowned-crane-bird-crane-animal-45853.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/1097456/pexels-photo-1097456.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/1766838/pexels-photo-1766838.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/1933239/pexels-photo-1933239.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/4793432/pexels-photo-4793432.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=279.825&fit=crop&h=453.05',
      'https://images.pexels.com/photos/1519088/pexels-photo-1519088.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/2681319/pexels-photo-2681319.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/1324803/pexels-photo-1324803.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/2131614/pexels-photo-2131614.jpeg?auto=compress&cs=tinysrgb&w=600'
    ];

    randomNum = List.generate(
        20,
        (_) => Random().nextInt(
            20)); //provides a random 20 random intergers from 0 to (20)
    randomcolor = List.generate(
        20,
        (_) => Random().nextInt(_color
            .length)); //provides random 20 integers from 0 to color.length-1
    randomimage = List.generate(20, (_) => Random().nextInt(image.length));
  }

  @override
  Widget build(BuildContext context) {
    displaylist = show ? _gridValues.take(10).toList() : _gridValues;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Assessment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: _color[0],
                  ),
                ),
                const Text(
                  'This is the Day 4 Assessment',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Text(
                  DateFormat('yMMMMdd').format(DateTime.now()),
                  style: const TextStyle(color: Colors.purple, fontSize: 20),
                ),
                Divider(
                  color: _color[0],
                  thickness: 10,
                  height: 36,
                ),
                SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.account_box),
                                title: Text('Person ${index + 1}'),
                                subtitle: Text(
                                  'Age ${Random().nextInt(35) + 15}', //provides value from 15 to 49
                                ),
                              );
                            },
                            itemCount: 10,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.account_box_outlined),
                                title: Text('Person ${index + 1}'),
                                subtitle: Text(
                                  'Age ${Random().nextInt(20) + 20}',
                                ),
                              );
                            },
                            itemCount: 10,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.account_box),
                                title: Text('Person ${index + 1}'),
                                subtitle: Text(
                                  'Age ${Random().nextInt(35) + 15}',
                                ),
                              );
                            },
                            itemCount: 10,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.account_box_outlined),
                                title: Text('Person ${index + 1}'),
                                subtitle: Text(
                                  'Age ${Random().nextInt(20) + 20}',
                                ),
                              );
                            },
                            itemCount: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: _color[1],
                  thickness: 10,
                  height: 25,
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: displaylist.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _color[randomcolor[index]],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              minRadius: 25,
                              backgroundImage:
                                  NetworkImage(image[randomimage[index]]),
                            ),
                            Text(_gridValues[randomNum[index]]['text']!),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      show = !show;
                    });
                  },
                  child: Text(show ? 'View More' : 'View Less'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
