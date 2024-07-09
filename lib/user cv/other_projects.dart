// import 'package:day5/models/other_model.dart';
// import 'package:day5/project.dart';
// import 'package:day5/widgets/pro.dart';
import 'package:day5/user%20cv/models/other_model.dart';
import 'package:day5/user%20cv/project.dart';
import 'package:day5/user%20cv/widgets/pro.dart';
import 'package:flutter/material.dart';

class Otherproject extends StatefulWidget {
  const Otherproject({super.key, required this.onSubmit});
  final Function(OthersModel othersModel) onSubmit;

  @override
  State<Otherproject> createState() => _OtherprojectState();
}

class _OtherprojectState extends State<Otherproject> {
  bool isSwitched = false;
  //
  List<OthersModel> otherList = [];

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
          OtherPro(otherpro: otherList),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Projects(
                        onSubmit: (othersModel) {
                          setState(() {
                            if (otherList.isNotEmpty) {
                              otherList.add(othersModel);
                            }
                          });
                          widget.onSubmit(othersModel);
                        },
                      ),
                    ));
              },
              icon: const Icon(Icons.add))
          //spread operator used to insert list of widget
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
