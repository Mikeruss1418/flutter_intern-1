// import 'package:day5/day6.dart';

import 'package:day5/models/exp_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Experience extends StatefulWidget {
  const Experience({super.key, required this.onSubmit});
  final Function(ExpModel expModel) onSubmit;

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  //
  // String? jobs;
  // String? companys;

  // void loadpreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   jobs = prefs.getString('jobtitle') ?? '';
  //   companys = prefs.getString('companyname') ?? '';
  // }

  //
  final formkey = GlobalKey<FormState>();
  //
  final TextEditingController job = TextEditingController();
  final TextEditingController summary = TextEditingController();
  final TextEditingController company = TextEditingController();

  // //
  //

  DateTime? sedate;
  DateTime? eedate;

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Experience '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Form(
            key: formkey,
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
                TextFormField(
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Job Title',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(),
                  ),
                  controller: job,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pervious job title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 100,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z _]'))
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Summary',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(),
                  ),
                  controller: summary,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please write your journey in that company';
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
                    labelText: 'Company',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(),
                  ),
                  controller: company,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pervious Company';
                    }
                    return null;
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
                      if (formkey.currentState!.validate() &&
                          sedate != null &&
                          eedate != null) {
                        //here if conditions are met
                        ExpModel expModel = ExpModel(
                            job: job.text,
                            company: company.text,
                            summary: summary.text,
                            sedate: sedate?.toIso8601String(),
                            eedate: eedate?.toIso8601String());

                        widget.onSubmit(
                            expModel); //callback fn where data of expModel is passed

                        // setState(() {
                        Navigator.pop(context); //pop back to previous scree/n
                        // });
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(content: Text('All VAlid')));
                      } else if (formkey.currentState!.validate() &&
                          (sedate == null || eedate == null)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid date range')),
                        );
                      }
                    },
                    child: const Text('Submit')),
                const Text('')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
