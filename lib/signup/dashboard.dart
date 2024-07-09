import 'dart:io';
import 'dart:math';

// import 'package:day5/models/signup_model.dart';
// import 'package:day5/pdfviewer.dart';
import 'package:day5/signup/pdfviewer.dart';
import 'package:day5/signup/sharedforsignup.dart';
import 'package:day5/signup/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:day5/sharedforsignup.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<SaveModel> modelList = [];
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    Helper helper = Helper();
    List<SaveModel> loadModelList = await helper.getModelList();
    setState(() {
      modelList = loadModelList;
    });
  }

  Future<void> _deleteFirstModel() async {
    Helper helper = Helper();
    await helper.deleteFirstModel();
    await load();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('one item deleted')),
    );
  }

  // void load() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     fullname = prefs.getString('fullname');
  //     email = prefs.getString('email');
  //     dob = prefs.getString('dob');
  //     mobile = prefs.getString('mobile');
  //     maritalstatus = prefs.getString('maritalstatus');
  //     password = prefs.getString('password');
  //     imagepath = prefs.getString('imagepath');
  //     cvpath = prefs.getString('cvpath');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dashboard"),
            IconButton(
                tooltip: 'Delete one at a time',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you sure '),
                        content: const Text(
                            'This will delete the first user details '),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                              onPressed: _deleteFirstModel,
                              child: const Text('Delete User')),
                        ],
                      );
                    },
                  );
                },
                // ()  {

                //   if (modelList.isNotEmpty) {
                //     SharedPreferences prefs =
                //         await SharedPreferences.getInstance();
                //     await prefs.clear();
                //     setState(() {
                //       modelList.clear();
                //     });
                //     setState(() {
                //       modelList.removeAt(0);
                //     });
                //   }
                // },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
      body: ListView.builder(
        // physics: cla,
        itemBuilder: (context, index) {
          SaveModel sModel = modelList[index];
          return Card(
            elevation: 5,
            shadowColor: const Color.fromARGB(255, 207, 205, 205),
            margin: const EdgeInsets.all(25),
            child: ListTile(
              // contentPadding: EdgeInsets.,

              leading: Text(
                '${index + 1} .',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Rtext(txt: 'Fullname: ', txtcontent: "${sModel.fullname}"),
                  Rtext(txt: 'Gender: ', txtcontent: '${sModel.gender}'),
                  Rtext(
                      txt: "DOB: ",
                      txtcontent: sModel.dob != null && sModel.dob!.isNotEmpty
                          ? DateFormat('y-MM-dd')
                              .format(DateTime.parse(sModel.dob!))
                          : 'No date selected'),
                  Rtext(txt: 'Mobile no: ', txtcontent: '${sModel.mobile}'),
                  Rtext(
                      txt: "Marital Status: ",
                      txtcontent: '${sModel.maritalstatus}'),
                  Rtext(txt: 'Email: ', txtcontent: "${sModel.email}"),
                  Rtext(txt: 'Password: ', txtcontent: '${sModel.password}'),
                  sModel.imagebase64 != null
                      ? Image(image: sModel.getImageProvider())
                      : const Text('no image'),
                  const SizedBox(
                    height: 10,
                  ),
                  sModel.cvpath != null
                      ? TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewer(filepath: sModel.cvpath!),
                                ));
                          },
                          child: const Text('Click here For CV pdf'))
                      : const Text('Not uploaded')
                ],
              ),
            ),
          );
        },
        itemCount: modelList.length,
      ),
    );
  }
}

class Rtext extends StatelessWidget {
  final String txt;
  final String txtcontent;
  const Rtext({super.key, required this.txt, required this.txtcontent});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(style: const TextStyle(color: Colors.black), children: [
      TextSpan(
          text: txt,
          style: const TextStyle(
            fontSize: 20,
          )),
      TextSpan(
          text: txtcontent,
          style: const TextStyle(
            fontSize: 15,
          ))
    ]));
  }
}
// Future<void> deleteFirstModel() async {
//   List<SaveModel> models = await getSavedModels();
//   if (models.isNotEmpty) {
//     models.removeAt(0);
//     await saveModels(models);
//   }
// }