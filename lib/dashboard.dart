import 'dart:io';
import 'dart:math';

import 'package:day5/models/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:day5/sharedforsignup.dart';

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
        title: const Text("Dashboard"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          SaveModel sModel = modelList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 20),
            elevation: 20,
            child: Column(
              children: [
                Text("Fullname: ${sModel.fullname}"),
                Text("Gender: ${sModel.gender}"),
                Text('DOB: ${sModel.dob}'),
                Text("Mobile no: ${sModel.mobile}"),
                Text("Maritial Status:${sModel.maritalstatus}"),
                Text("Email: ${sModel.email}"),
                Text("Password: ${sModel.password}"),
                sModel.imagebase64 != null
                    ? Image(image: sModel.getImageProvider())
                    : Text('no image'),
                // Image.file(File(sModel.imagepath!)),
              ],
            ),
          );
        },
        itemCount: modelList.length,
      ),
      // body: ListView(
      //   children: [
      //     if (fullname != null) Text('Fullname : $fullname'),
      //     if (password != null) Text('Email : $email'),
      //     if (imagepath != null) Image.file(File(imagepath!)),
      //     if (email != null) Text('Email: $email'),
      //   ],
      // ),
    );
  }
}
