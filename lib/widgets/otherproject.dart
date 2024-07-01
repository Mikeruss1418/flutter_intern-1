import 'package:day5/widgets/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Otherproject extends StatefulWidget {
  const Otherproject({super.key});

  @override
  State<Otherproject> createState() => _OtherprojectState();
}

class _OtherprojectState extends State<Otherproject> {
  bool isSwitched = false;
  //
  final TextEditingController project = TextEditingController();
  final TextEditingController descrip = TextEditingController();
  final TextEditingController organization = TextEditingController();
  //
  String? errortxttitle;
  String? errortxtdescrip;
  String? errortxtorganization;
  //
  DateTime? sdate;
  DateTime? edate;
  //
  String? selectedvalue;
  bool isSelected = false;
  //
  void validateTitle() {
    setState(() {
      if (project.text.isEmpty) {
        errortxttitle = 'Please enter your Project title';
      } else {
        errortxttitle = null;
      }
    });
  }

  void validateDescrip() {
    setState(() {
      if (descrip.text.isEmpty) {
        errortxtdescrip = 'Please provide details about your project';
      } else {
        errortxtdescrip = null;
      }
    });
  }

  void validateAssociation() {
    setState(() {
      if (organization.text.isEmpty) {
        errortxtorganization = 'Must reveal Association';
      } else {
        errortxtorganization = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Other Projects",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                }),
          ],
        ),
        if (isSwitched) ...[
          //spread operator used to insert list of widget
          Field(
            fliter: FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')),
            labeltxt: 'Project Title',
            controller: project,
            errortxt: errortxttitle,
            maxLength: 10,
            onchange: (value) {
              validateTitle();
            },
          ),
          Field(
            fliter: FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z _]')),
            labeltxt: 'Description',
            controller: descrip,
            maxlines: 6,
            minlines: 1,
            errortxt: errortxtdescrip,
            maxLength: 100,
            onchange: (value) {
              validateDescrip();
            },
          ),
          Row(
            children: [
              Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        DateTime? startdate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2023, 12, 31));

                        if (startdate != null) {
                          setState(() {
                            sdate = startdate;
                          });
                        }
                      },
                      child: const Text('Start Date')),
                  Text(sdate == null
                      ? ' '
                      : DateFormat('y-MMM-dd').format(sdate!)),
                ],
              ),
              Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        DateTime? enddate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2023, 12, 31));

                        if (enddate != null) {
                          setState(() {
                            edate = enddate;
                          });
                        }
                      },
                      child: const Text('End Date')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(edate == null
                        ? ' '
                        : DateFormat('y-MMM-dd').format(edate!)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Associated with any organzation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              Wrap(
                runSpacing: -22,
                children: [
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: 'Yes',
                      groupValue: selectedvalue,
                      onChanged: (value) {
                        setState(() {
                          selectedvalue = value;
                          isSelected = !isSelected;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: 'No',
                      groupValue: selectedvalue,
                      onChanged: (value) {
                        setState(() {
                          selectedvalue = value;
                          isSelected = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (isSelected) ...[
                Field(
                  fliter:
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')),
                  labeltxt: 'Organization name',
                  controller: organization,
                  errortxt: errortxtorganization,
                  maxLength: 10,
                  onchange: (value) {
                    validateAssociation();
                  },
                )
              ]
            ],
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Submit'))
        ],
        // The '...[]' is the spread operator,
        //which is used to insert all the elements of a list into another list.
        /*It was used to dynamically include widgets based on a condition (isSwitched). 
          It does not necessarily have to be related to a map or any other specific data structure.
          The primary purpose of the if (isSwitched) ...[] syntax is to control the inclusion of widgets
          in the widget tree based on a condition.*/
      ],
    );
  }
}
