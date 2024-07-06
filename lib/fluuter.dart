
import 'package:day5/models/for_project.dart';
import 'package:day5/sharedpreferences.dart';
import 'package:day5/widgets/pro.dart';
import 'package:day5/widgets/work.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Flutter extends StatefulWidget {
  const Flutter({
    super.key,
  });

  @override
  State<Flutter> createState() => _HomeState();
}

class _HomeState extends State<Flutter> {
  // String fname = '';
  SharedPreferenceHelper list = SharedPreferenceHelper();

  List<CvModel> modelList = [];
  @override
  void initState() {
    super.initState();
    _loadModelList();
  }

  // Future<void> addUserModel(CvModel userModel) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? jsonStringList = prefs.getStringList('model_list');
  //   List<CvModel> modelList = [];

  //   if (jsonStringList != null) {
  //     modelList = jsonStringList
  //         .map((jsonString) => CvModel.fromJson(jsonDecode(jsonString)))
  //         .toList();
  //   }

  //   modelList.add(userModel);

  //   List<String> updatedJsonStringList =
  //       modelList.map((model) => jsonEncode(model.toJson())).toList();

  //   await prefs.setStringList('model_list', updatedJsonStringList);
  // }

  Future<void> _loadModelList() async {
    SharedPreferenceHelper helper = SharedPreferenceHelper();
    List<CvModel> loadedModelList = await helper.getModelList();
    setState(() {
      modelList = loadedModelList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Shared preferences'),
          InkWell(
              onTap: () {
                if (modelList.isNotEmpty) {
                  setState(() {
                    modelList.removeAt(0);
                  });
                }
              },
              child: const Icon(Icons.menu))
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemBuilder: (context, index) {
              CvModel cvModel = modelList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 20),
                elevation: 20,
                child: Column(
                  children: [
                    // Text('Sn.no: ${index + 1}'),
                    Text('first name: ${cvModel.fname ?? ''}'),
                    Text('middle name: ${cvModel.mname ?? ''}'),
                    Text('last name: ${cvModel.lname ?? ''}'),
                    Text('age: ${cvModel.age ?? ''}'),
                    Text('gender ${cvModel.gender ?? ''}'),
                    Text('Skills ${cvModel.skills ?? 'none at all'}'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Education',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("College/Institution name: ${cvModel.college ?? ' '}"),
                    Text("Level of Education(completed): ${cvModel.level}"),
                    Text(
                        'Education Start date ${DateFormat('y-MMM-dd').format(DateTime.parse(cvModel.sdate ?? ''))}'),
                    Text(
                        'Education End Date ${DateFormat('y-MMM-dd').format(DateTime.parse(cvModel.edate ?? ''))}'),
                    Text(
                        'Achievements : ${cvModel.acheivement ?? ' Text(Achievements)'}'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Work Experience',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Work(work: cvModel.exlist ?? []),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Other Projects',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OtherPro(otherpro: cvModel.otlist ?? []),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Languages :${cvModel.languages ?? ''}'),
                    Text('Interest :${cvModel.interest ?? ''} ')
                  ],
                ),
              );
            },
            // separatorBuilder: (context, index) {
            //   return const Divider(
            //     color: Colors.black,
            //     height: 20,
            //     thickness: 10,
            //   );
            // },
            itemCount: modelList.length),
      ),
    );
  }
}
