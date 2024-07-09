
// import 'package:day5/models/exp_model.dart';
import 'package:day5/user%20cv/models/exp_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Work extends StatelessWidget {
  const Work({super.key, required this.work});

  final List<ExpModel> work;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Job title :${work[index].job}'),
              Text('Summary :${work[index].summary}'),
              Text('Company ${work[index].company}'),
              Text(
                  'Start date : ${DateFormat('y-MMM-dd').format(DateTime.parse(work[index].sedate ?? ''))}'),
              Text(
                  'End date : ${DateFormat('y-MMM-dd').format(DateTime.parse(work[index].eedate ?? ''))}'),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 10,
            thickness: 5,
          );
        },
        itemCount: work.length);
  }
}
