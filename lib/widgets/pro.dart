
import 'package:day5/models/other_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OtherPro extends StatelessWidget {
  const OtherPro({super.key, required this.otherpro});
  final List<OthersModel> otherpro;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text('Project name: ${otherpro[index].project}'),
              Text('Description: ${otherpro[index].descrip}'),
              Text(
                  'Start Date: ${DateFormat('y-MMM-dd').format(DateTime.parse(otherpro[index].sdate ?? ' '))}'),
              Text(
                  'End Date: ${DateFormat('y-MMM-dd').format(DateTime.parse(otherpro[index].edate ?? ' '))}'),
              Text("Association : ${otherpro[index].association}"),
              Text(
                  'Organization: ${otherpro[index].organization ?? 'No Association'}'),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 10,
            thickness: 10,
          );
        },
        itemCount: otherpro.length);
  }
}
