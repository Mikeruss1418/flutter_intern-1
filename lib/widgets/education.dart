import 'package:day5/day6.dart';
import 'package:day5/widgets/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Education extends StatefulWidget {
  // final Function(String? val)? onCompanyChange;
  const Education({
    super.key,
    /*this.onCompanyChange*/
  });

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final TextEditingController college = TextEditingController();
  String? errortxtcollege;
  DateTime? sdate;
  DateTime? edate;
  //
  String? dropdownValue;
//
  void validateCollege() {
    setState(() {
      if (college.text.isEmpty) {
        errortxtcollege = 'Please enter Institution name';
      } else {
        errortxtcollege = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Education',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            Field(
              labeltxt: 'Organization Name(Insitution/College)',
              fliter: FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z _]')),
              controller: college,
              errortxt: errortxtcollege,
              maxLength: 10,
              onchange: (currentvalue) {
                validateCollege();
                // if (widget.onCompanyChange != null) {
                //   widget.onCompanyChange!(errortxtcollege);
                // }
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
                  DropdownMenuItem(value: 'Bachelor', child: Text('Bachelor')),
                  DropdownMenuItem(value: 'Master', child: Text('Master')),
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
                        if (startdate != null) {
                          setState(() {
                            sdate = startdate;
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
              child: Field(
                fliter:
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z _]')),
                labeltxt: 'Achievements',
                minlines: 1,
                maxlines: 6,
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}
