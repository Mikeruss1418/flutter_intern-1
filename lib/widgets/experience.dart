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
  DateTime? sdate;
  DateTime? edate;
  //
  final TextEditingController job = TextEditingController();
  final TextEditingController summary = TextEditingController();
  final TextEditingController company = TextEditingController();
  //
  String? errortxtj;
  String? errortxts;
  String? errortxtc;
  //
  void validateJob() {
    setState(() {
      if (job.text.isEmpty) {
        errortxtj = 'Please enter your previous job title';
      } else {
        errortxtj = null;
      }
    });
  }

  //
  void validateSummary() {
    setState(() {
      if (summary.text.isEmpty) {
        errortxts = 'Tell us about your previous job experience';
      } else {
        errortxts = null;
      }
    });
  }

  //
  void validateCompany() {
    setState(() {
      if (company.text.isEmpty) {
        errortxtc = 'Tell us the name of your previous company';
      } else {
        errortxtc = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            fliter:
                FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'), allow: true),
            maxLength: 10,
            controller: job,
            errortxt: errortxtj,
            onchange: (value) {
              validateJob();
            },
          ),
          Field(
            fliter: FilteringTextInputFormatter.allow(RegExp(
                r'[A-Za-z _]')), //for alphanumeric and space RegExp(r'[A-Za-z0-9 _]')
            labeltxt: 'Summary',
            maxLength: 100,
            maxlines: 3,
            controller: summary,
            errortxt: errortxts,
            onchange: (value) {
              validateSummary();
            },
          ),
          Field(
            fliter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
            labeltxt: 'Company Name',
            maxLength: 2,
            controller: company,
            errortxt: errortxtc,
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
                        lastDate: DateTime.now(),
                      );
                      if (startdate != null) {
                        setState(() {
                          sdate = startdate;
                        });
                      }
                    },
                    child: const Text('Starting Date'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(sdate == null
                        ? ' '
                        : DateFormat('yMMMMdd').format(sdate!)),
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
                          lastDate: DateTime.now());
                      //codtioon of displaying choosen date
                      if (enddate != null) {
                        setState(() {
                          edate = enddate;
                        });
                      }
                    },
                    child: const Text('Ending Date'),
                    //here format is DateTime and edate is DateTime?
                    //because of that a null check is introduced here
                  ),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.white)),
                    child: Text(edate == null
                        ? ' '
                        : DateFormat('yMMMMdd').format(edate!)),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
