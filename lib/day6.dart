import 'package:day5/widgets/checkboxes.dart';
import 'package:day5/widgets/cv_output.dart';
import 'package:day5/widgets/education.dart';
import 'package:day5/widgets/experience.dart';
import 'package:day5/widgets/field.dart';
import 'package:day5/widgets/otherproject.dart';
import 'package:day5/widgets/shared_statemanagemen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Day6 extends StatefulWidget {
  const Day6({super.key});

  @override
  State<Day6> createState() => _HomeState();
}

class _HomeState extends State<Day6> {
  // List<DynamicWidget> exptile = [];


  String? _selectedgender;
  List skills = ['flutter', 'java', 'JS', 'Kotlin', 'C', 'C++', 'Swift'];
  late List sklist; //here late modifier because it is used
//
  String? _errortxtf;
  String? _errortxtm;
  String? _errortxtl;
  String? _errortxtage;
  // var exp = Experience.errortxtj;

//

  @override
  void initState() {
    super.initState();
    sklist = List.generate(skills.length,
        (index) => false); //provides 7 false value as initialized
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
      if (SharedState.fname.text.isEmpty) {
        _errortxtf = 'Please enter your first name';
      } else {
        _errortxtf = null;
      }
    });
  }

  

  void validateMname() {
    //this was created just to "change the errortxt of middle name on textchange"
    setState(() {
      if (SharedState.mname.text.isEmpty) {
        _errortxtm = 'Please enter your middle name';
      } else {
        _errortxtm = null;
      }
    });
  }

  void validateLname() {
    setState(() {
      if (SharedState.lname.text.isEmpty) {
        _errortxtl = 'Please enter your last name';
      } else {
        _errortxtl = null;
      }
    });
  }

  void validateAge() {
    setState(() {
      if (int.parse(SharedState.age.text) > 65) {
        //it parse the input data into integer
        _errortxtage = 'Age Exceeded';
      } else if (int.parse(SharedState.age.text) <= 0) {
        _errortxtage = 'Invalid SharedState.age';
      } else if (int.parse(SharedState.age.text) <= 17) {
        _errortxtage = 'Underage';
      } else if (SharedState.age.text.isEmpty) {
        _errortxtage = 'Please enter your SharedState.SharedState.age';
      } else {
        _errortxtage = null;
      }
    });
  }

  @override
  void dispose() {
    //a good habit if using texteditingcontroller() or animationcontroller, removes the widget which leaves the tree in a safe manner.
    SharedState.fname.dispose();
    SharedState.mname.dispose();
    SharedState.lname.dispose();
    SharedState.age.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //data/arguments passed inside this is reinitialized everytime a build function is called

    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0), //child of conatinr padding
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
              Container(
                // height: 500,
                // padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  // border: Border.all(),
                  // color: Colors.amber,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Field(
                      labeltxt: 'First Name',
                      fliter: FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-z]')),
                      errortxt: _errortxtf,
                      controller: SharedState.fname,
                      maxLength: 10,
                      onchange: (value) {
                        validateFname();
                      },
                    ),
                    Field(
                      labeltxt: 'Middle Name',
                      fliter: FilteringTextInputFormatter.allow(
                          RegExp(r'[A-Za-z]')),
                      maxLength: 10,
                      controller: SharedState.mname,
                      errortxt: _errortxtm,
                      onchange: (value) {
                        validateMname();
                      },
                    ),
                    Field(
                      labeltxt: 'Last Name',
                      fliter: FilteringTextInputFormatter.allow(
                        RegExp(r'[A-Za-z]'),
                      ),
                      maxLength: 10,
                      controller: SharedState.lname,
                      errortxt: _errortxtl,
                      onchange: (value) {
                        validateLname();
                      },
                    ),
                    Field(
                      labeltxt: 'Age',
                      controller: SharedState.age,
                      keyboard: TextInputType.number,
                      errortxt: _errortxtage,
                      fliter: FilteringTextInputFormatter.digitsOnly,
                      maxLength: 2,
                      onchange: (value) {
                        validateAge();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 300),
                          child: const Text(
                            'Skills',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                          ).toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Work Experience',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Experience(),
                                    ));
                              });
                            },
                            child: const Icon(
                              Icons.add,
                            ))
                      ],
                    ),
                   
                    // Card(
                    //     shape: const RoundedRectangleBorder(),
                    //     elevation: 10,
                    //     child: SizedBox(
                    //       width: double.infinity,
                    //       child: Stack(
                    //         // alignment: Alignment(-.9, 0),
                    //         children: [
                    //           Align(
                    //             alignment: const Alignment(-0.9, 0),
                    //             child: Column(
                    //               children: [
                    //                 Text('Job Title: ${SharedState.job.text}'),
                    //                 Text(
                    //                     'Summary: ${SharedState.summary.text}'),
                    //                 Text(
                    //                     'Company name: ${SharedState.company.text}'),
                    //                 Text('Start date: ${SharedState.sedate}'),
                    //                 Text(
                    //                     'End Date: ${SharedState.eedate.toString()}')
                    //               ],
                    //             ),
                    //           ),
                    //           Align(
                    //             alignment: const Alignment(1, 0),
                    //             child: TextButton(
                    //                 onPressed: () {},
                    //                 child: const Icon(Icons.delete)),
                    //           )
                    //         ],
                    //       ),
                    //     )), // const Experience(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add Education",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Education()));
                              });
                            },
                            child: const Icon(Icons.add))
                      ],
                    ),
                    // Education(
                    //   // onCompanyChange: (val) {},
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Otherproject(),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    const Languages(),
                    const InterestAreas(),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_errortxtf == null &&
                                _errortxtl == null &&
                                _errortxtm == null &&
                                _errortxtage == null &&
                                SharedState.errortxtj == null &&
                                SharedState.errortxts == null &&
                                SharedState.errortxtc == null &&
                                (_selectedgender == 'Male' ||
                                    _selectedgender == "Female")) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Cvresult()));
                            } else {
                              print('error');
                            }
                          });

                          //
                        },
                        child: const Text('Save'))
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

AppBar appBar() {
  return AppBar(
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
  );
}
