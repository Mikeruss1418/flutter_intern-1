import 'dart:convert';
import 'dart:developer';
import 'package:day5/exp.dart';
import 'package:day5/fluuter.dart';
import 'package:day5/models/exp_model.dart';
import 'package:day5/models/for_project.dart';
import 'package:day5/models/other_model.dart';
import 'package:day5/other_projects.dart';
import 'package:day5/sharedpreferences.dart';
import 'package:day5/widgets/work.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class UserCV extends StatefulWidget {
  const UserCV({
    super.key,
  });
  // final Function(Project cv) onSubmit;

  @override
  State<UserCV> createState() => _UserCVState();
}

class _UserCVState extends State<UserCV> {
  ExpModel? expModel;
  CvModel? model;
  OthersModel? othersModel;

  final formkey = GlobalKey<FormState>();
  String? _selectedgender;
  List skills = ['flutter', 'java', 'JS', 'Kotlin', 'C', 'C++', 'Swift'];
  @override
  void initState() {
    super.initState();
    // loadData();
    loadModel();
    // saveData();
  }

  Future<void> saveModel(CvModel model) async {
    SharedPreferenceHelper().addUserModel(model);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String cvString = json.encode(model.toJson());
    // log(cvString);
    // await prefs.setString('user_data', cvString);
  }

  Future<void> loadModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonmodel = prefs.getString('user_data');
    if (jsonmodel != null) {
      setState(() {
        //instance of ExpModel
        model = CvModel.fromJson(jsonDecode(jsonmodel));
        log(jsonmodel);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }

  @override
  void dispose() {
    // routeObserver.unsubscribe(this as RouteAware);
    fname.dispose();
    mname.dispose();
    lname.dispose();
    age.dispose();
    college.dispose();

    super.dispose();
  }

  void didPopNext() {
    setState(() {
      fname.clear();
      workExpList.clear();
      mname.clear();
      selectedchip.clear();
      sinterest.clear();
      slanguages.clear();
    });
  }

  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController mname = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController college = TextEditingController();
  final TextEditingController achievement = TextEditingController();

  String? dropdownValue;
  DateTime? sdate;
  DateTime? edate;
  List<String> selectedchip = [];
  Map<String, bool> interest = {
    'Sporting': false,
    'Gaming': false,
    'Cooking': false,
    'Reading': false,
  };
  List<String> sinterest = [];
  Map<String, bool> languages = {
    'Hindi': false,
    "Nepali": false,
    'English': false,
    'Newari': false,
  };
  List<String> slanguages = [];
  List<ExpModel> workExpList = [];
  List<OthersModel> otherList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('User CV'),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Flutter(),
                      ));
                },
                child: const Icon(Icons.menu)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                    ],
                    decoration: const InputDecoration(
                      labelText: 'First name',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                    ),
                    controller: fname,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Middle name',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                    ),
                    controller: mname,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your middle name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Last name',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                    ),
                    controller: lname,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                    ),
                    controller: age,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your age";
                      } else if (int.parse(value) <= 0) {
                        return "Please enter valid age";
                      }
                      return null;
                    },
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Skills',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Wrap(
                        children: skills.map((skill) {
                          return ChoiceChip(
                            label: Text(skill),
                            selected: selectedchip.contains(skill),
                            selectedColor: Colors.purple,
                            onSelected: (value) {
                              setState(() {
                                if (value) {
                                  selectedchip.add(skill);
                                } else {
                                  selectedchip.remove(skill);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Selected: ${selectedchip.join(', ')}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Work Experience of ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Experience(
                                        onSubmit: (expModel) {
                                          setState(() {
                                            workExpList.add(expModel);
                                          });

                                          // print(workExpList.length);
                                        },
                                      ),
                                    ));
                              });
                            },
                            child: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Work(work: workExpList),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          workExpList.removeAt(0);
                        });
                      },
                      child: const Icon(Icons.delete)),
                  const Text(
                    'Education',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                    ],
                    decoration: const InputDecoration(
                      labelText: 'College name',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                    ),
                    controller: college,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your college name';
                      }
                      return null;
                    },
                  ),
                  DropdownButton(
                      value: dropdownValue,
                      hint: Text(
                        'Level',
                        style: TextStyle(color: Colors.purple[400]),
                      ),
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      items: const [
                        DropdownMenuItem(value: 'SEE', child: Text('SEE')),
                        DropdownMenuItem(value: '+2', child: Text('+2')),
                        DropdownMenuItem(
                            value: 'Bachelor', child: Text('Bachelor')),
                        DropdownMenuItem(
                            value: 'Master', child: Text('Master')),
                        DropdownMenuItem(value: 'PHD', child: Text('PHD')),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value;
                        });
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              DateTime? startdate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2023, 12, 31));
                              if (startdate != null && startdate != sdate) {
                                setState(() {
                                  sdate = startdate;
                                  edate = null;
                                });
                              }
                            },
                            child: const Text('Start Date'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Text(
                              sdate == null
                                  ? ' '
                                  : DateFormat('y-MMM-dd').format(sdate!),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          TextButton(
                              onPressed: () async {
                                if (sdate == null) {
                                  return;
                                }
                                DateTime? enddate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2023, 12, 31));
                                if (enddate != null && enddate != edate) {
                                  setState(() {
                                    edate = enddate;
                                  });
                                }
                              },
                              child: const Text('End date')),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(edate == null
                                ? ' '
                                : DateFormat('y-MMM-dd').format(edate!)),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 6,
                      maxLength: 100,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Achievement',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                      ),
                      controller: achievement,
                    ),
                  ),

                  Otherproject(
                    onSubmit: (othersModel) {
                      setState(() {
                        otherList.add(othersModel);
                      });
                    },
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        setState(() {
                          if (otherList.isNotEmpty) {
                            otherList.removeAt(0);
                          }
                        });
                      },
                      child: const Icon(Icons.delete)),
                  const Text(
                    'Languages',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Wrap(
                    runSpacing: -20,
                    children: languages.keys.map((String lang) {
                      return CheckboxListTile(
                        title: Text(lang),
                        value: languages[lang],
                        onChanged: (value) {
                          setState(() {
                            languages[lang] = value!;
                            if (value) {
                              slanguages.add(lang);
                            } else {
                              slanguages.remove(lang);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                  Text('Selected: ${slanguages.join(',')}'),
                  const Text('Interested Areas',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  Wrap(
                    runSpacing: -22,
                    children: interest.keys.map((String inter) {
                      return CheckboxListTile(
                          title: Text(inter),
                          value: interest[inter],
                          onChanged: (value) {
                            setState(() {
                              interest[inter] = value!;
                              if (value) {
                                sinterest.add(inter);
                              } else {
                                sinterest.remove(inter);
                              }
                            });
                          });
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("selected: ${sinterest.join(',')}"),
                  // const Languages(),
                  // const InterestAreas(),

                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate() &&
                            (sdate != null && edate != null) &&
                            workExpList.isNotEmpty &&
                            otherList.isNotEmpty &&
                            (_selectedgender == 'Male' ||
                                _selectedgender == 'Female')) {
                          CvModel model = CvModel(
                              fname: fname.text,
                              mname: mname.text,
                              lname: lname.text,
                              age: age.text,
                              gender: _selectedgender,
                              level: dropdownValue,
                              college: college.text,
                              acheivement: achievement.text,
                              sdate: sdate!.toIso8601String(),
                              edate: edate!.toIso8601String(),
                              languages: slanguages,
                              interest: sinterest,
                              skills: selectedchip,
                              exlist: workExpList,
                              otlist: otherList);
                          saveModel(model);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Confirm Save"),
                                content: const Text(
                                    "Do you want to save this data?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('cancel')),
                                  TextButton(
                                    onPressed: () {
                                      // print("ttessssssssssssssssssssssst");

                                      setState(() {
                                        fname.clear();
                                        mname.clear();
                                        lname.clear();
                                        age.clear();
                                        college.clear();
                                        achievement.clear();
                                        _selectedgender = null;
                                        selectedchip.clear();
                                        sinterest.clear();
                                        
                                        slanguages.clear();
                                        sdate = null;
                                        edate = null;
                                        workExpList.clear();
                                        // otherList.clear();
                                        for (String key
                                            in interest.keys.toList()) {
                                          interest[key] = false;
                                        }
                                        for (String key
                                            in languages.keys.toList()) {
                                          languages[key] = false;
                                        }
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
