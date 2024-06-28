// import 'dart:developer';

import 'package:day5/widgets/experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/field.dart';

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
  final TextEditingController fname = TextEditingController();
  final TextEditingController mname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController age = TextEditingController();

  String _selectedgender = 'Male';
  List skills = ['flutter', 'java', 'JS', 'Kotlin', 'C', 'C++', 'Swift'];
  late List sklist; //here late modifier because it is used
//
  String? _errortxtf;
  String? _errortxtm;
  String? _errortxtl;
  String? _errortxtage;
//

  @override
  void initState() {
    super.initState();
    sklist = List.generate(
        7, (index) => false); //provides 7 false value as initialized
  }
  /*The reason sklist in kept inside initstate is due to the fact that it is called only once.
  Here, when we launch the app,and reaches to a 'setstate' flutter update that widget's state has been changed and it needs a rebuilt,
  so flutter calls the build function again to create the UI based on the changed state.
  As the flutter calls the rebuild method, everything inside the build method is reset.
  Due to this reason, sklist was not kept inside the widget (build),as it causes to reset everytime setstate is called and app is rebuild.

  Effect on ChoiceChip Widgets: ChoiceChip widgets use _skills[index] to determine their selected state.
  If _skills is reset (recreated with List.generate), all ChoiceChip widgets would reset to their default state (false). */

  void validateFname() {
    //this was created to change the specific textfield errortxt
    setState(() {
      if (fname.text.isEmpty) {
        _errortxtf = 'Please enter your first name';
      } else {
        _errortxtf = null;
      }
    });
  }

  void validateMname() {
    //this was created just to "change the errortxt of middle name on textchange"
    setState(() {
      if (mname.text.isEmpty) {
        _errortxtm = 'Please enter your middle name';
      } else {
        _errortxtf = null;
      }
    });
  }

  void validateLname() {
    setState(() {
      if (lname.text.isEmpty) {
        _errortxtl = 'Please enter your last name';
      } else {
        _errortxtl = null;
      }
    });
  }

  void validateAge() {
    setState(() {
      if (int.parse(age.text) > 65) {
        //it parse the input data into integer
        _errortxtage = 'Age Exceeded';
      } else if (int.parse(age.text) <= 0) {
        _errortxtage = 'Invalid age';
      } else if (int.parse(age.text) <= 17) {
        _errortxtage = 'Underage';
      } else if (age.text.isEmpty) {
        _errortxtage = 'Please enter your age';
      } else {
        _errortxtage = null;
      }
    });
  }

  @override
  void dispose() {
    //a good habit if using texteditingcontroller() or animationcontroller, removes the widget which leaves the tree in a safe manner.
    fname.dispose();
    mname.dispose();
    lname.dispose();
    age.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //data/arguments passed inside this is reinitialized everytime a build function is called

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        elevation: 20,
        shadowColor: const Color.fromARGB(188, 229, 226, 226),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'User CV',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            Icon(Icons.menu)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), //whole screen padding
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0), //child container padding
                child: Container(
                  padding:
                      const EdgeInsets.all(8.0), //child of conatinr padding
                  width: double.infinity,
                  height: 100,
                  decoration: const BoxDecoration(
                      // color: Color.fromARGB(188, 229, 226, 226),
                      ),
                  child: const Text(
                    "Let's Begin !!",
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              ),
              Container(
                // height: 500,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  // border: Border.all(),
                  // color: Colors.amber,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Field(
                        labeltxt: 'First Name',
                        fliter: FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-z]')),
                        errortxt: _errortxtf,
                        controller: fname,
                        maxLength: 10,
                        onchange: (value) {
                          validateFname();
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Field(
                          labeltxt: 'Middle Name',
                          fliter: FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Za-z]')),
                          maxLength: 10,
                          controller: mname,
                          errortxt: _errortxtm,
                          onchange: (value) {
                            validateMname();
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Field(
                            labeltxt: 'Last Name',
                            fliter: FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Za-z]'),
                            ),
                            maxLength: 10,
                            controller: lname,
                            errortxt: _errortxtl,
                            onchange: (value) {
                              validateLname();
                            })),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Field(
                          labeltxt: 'Age',
                          controller: age,
                          keyboard: TextInputType.number,
                          errortxt: _errortxtage,
                          fliter: FilteringTextInputFormatter.digitsOnly,
                          maxLength: 2,
                          onchange: (value) {
                            validateAge();
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 5,
                                  blurRadius: 2,
                                  offset: Offset(7, 12),
                                  color: Color.fromARGB(31, 187, 185, 185))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gender',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Wrap(
                              //remember scroll direction is horizontal
                              spacing: 5,
                              runSpacing:
                                  -20, //here is provided spacing between male and female in vertical
                              children: [
                                ListTile(
                                  title: const Text('Male'),
                                  leading: Radio(
                                    value: 'Male',
                                    groupValue: _selectedgender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedgender = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Female'),
                                  leading: Radio(
                                    value: 'Female',
                                    groupValue: _selectedgender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedgender =
                                            value!; //this say that when i click to another button,
                                        //the setstate(() {}) changes the default value of _selectedgender to the new value which
                                        //which was clicked just now,  this caputres every changes that occur.
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Container(
                        // height: 132,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 5,
                                  blurRadius: 2,
                                  offset: Offset(7, 12),
                                  color: Color.fromARGB(31, 187, 185, 185))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Skills',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Wrap(
                                spacing: 4.0,
                                // runSpacing: 2.0,
                                children: List.generate(
                                  skills.length,
                                  (index) {
                                    return ChoiceChip(
                                      label: Text(skills[index]),
                                      selected: sklist[index],
                                      selectedColor: Colors.purple,
                                      onSelected: (value) {
                                        setState(() {
                                          sklist[index] = value;
                                        });
                                      },
                                    );
                                  },
                                ).toList()),
                            const Experience(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Submit'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// here use pageView
