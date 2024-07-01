import 'package:day5/day6.dart';
import 'package:day5/widgets/shared_statemanagemen.dart';

// import 'package:day5/day6.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'field.dart';

class Experience extends StatefulWidget {
  const Experience({super.key});

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  //

  // //
  //

  DateTime? sedate;
  DateTime? eedate;

  //
  void validateJob() {
    setState(() {
      if (SharedState.job.text.isEmpty) {
        SharedState.errortxtj = 'Please enter your previous job title';
      } else {
        SharedState.errortxtj = null;
      }
    });
  }

  //
  void validateSummary() {
    setState(() {
      if (SharedState.summary.text.isEmpty) {
        SharedState.errortxts = 'Tell us about your previous job experience';
      } else {
        SharedState.errortxts = null;
      }
    });
  }

  //
  void validateCompany() {
    setState(() {
      if (SharedState.company.text.isEmpty) {
        SharedState.errortxtc =
            'Tell us the name of your previous SharedState.company';
      } else {
        SharedState.errortxtc = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Work Experience',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Field(
                labeltxt: 'Job Title',
                fliter: FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'),
                    allow: true),
                maxLength: 10,
                controller: SharedState.job,
                errortxt: SharedState.errortxtj,
                onchange: (value) {
                  validateJob();
                },
              ),
              Field(
                fliter: FilteringTextInputFormatter.allow(RegExp(
                    r'[A-Za-z _]')), //for alphanumeric and space RegExp(r'[A-Za-z0-9 _]')
                labeltxt: 'Summary',
                maxLength: 100,
                minlines: 1,
                maxlines: 6,
                controller: SharedState.summary,
                errortxt: SharedState.errortxts,
                onchange: (value) {
                  validateSummary();
                },
              ),
              Field(
                fliter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                labeltxt: 'Company Name',
                maxLength: 10,
                controller: SharedState.company,
                errortxt: SharedState.errortxtc,
                onchange: (value) {
                  validateCompany();
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
                            lastDate: DateTime(2023, 12, 31),
                          );
                          if (startdate != null) {
                            setState(() {
                              sedate = startdate;
                            });
                          }
                        },
                        child: const Text('Start Date'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(sedate == null
                            ? ' '
                            : DateFormat('y-MMM-dd').format(sedate!)),
                      ),
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
                          //codtioon of displaying choosen date
                          if (enddate != null) {
                            setState(() {
                              eedate = enddate;
                            });
                          }
                        },
                        child: const Text('End Date'),
                        //here format is DateTime and edate is DateTime?
                        //because of that a null check is introduced here
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Text(eedate == null
                            ? ' '
                            : DateFormat('y-MMM-dd').format(eedate!)),
                      )
                    ],
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (SharedState.errortxtj == null &&
                          SharedState.errortxts == null &&
                          SharedState.errortxtc == null &&
                          eedate != null &&
                          sedate != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Day6()));
                      }
                    });
                  },
                  child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
