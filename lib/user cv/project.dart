import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'models/other_model.dart';

class Projects extends StatefulWidget {
  const Projects({super.key, required this.onSubmit});
  final Function(OthersModel othersModel) onSubmit;

  @override
  State<Projects> createState() => _HomeState();
}

class _HomeState extends State<Projects> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController project = TextEditingController();
  final TextEditingController descrip = TextEditingController();
  final TextEditingController organization = TextEditingController();
  DateTime? sdate;
  DateTime? edate;
  String? selectedvalue;
  bool isSelected = false;
  String jobTitle = '';
  String summaries = '';
  String companies = '';
  List<OthersModel> otherList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Projects'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Project Title',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                      ),
                      controller: project,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Project name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: descrip,
                      maxLength: 100,
                      minLines: 1,
                      maxLines: 6,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]'))
                      ],
                      decoration: const InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide details about the project";
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
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
                          TextFormField(
                            controller: organization,
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Za-z]'))
                            ],
                            decoration: const InputDecoration(
                              labelText: "Organization name",
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter the organization name';
                              }
                              return null;
                            },
                          )
                        ]
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate() &&
                              selectedvalue != null &&
                              sdate != null &&
                              edate != null) {
                            OthersModel othersModel;
                            othersModel = OthersModel(
                              project: project.text,
                              descrip: descrip.text,
                              organization: organization.text,
                              association: selectedvalue,
                              sdate: sdate?.toIso8601String(),
                              edate: edate?.toIso8601String(),
                              onSubmit: (othersModel) {
                                setState(() {
                                  otherList.add(othersModel);
                                });
                              },
                            );

                            widget.onSubmit(othersModel);

                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Submit'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
