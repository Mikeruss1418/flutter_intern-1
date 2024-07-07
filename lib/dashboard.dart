import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    load();
  }

  String? fullname;
  String? email;
  String? imagepath;
  String? dob;
  String? mobile;
  String? maritalstatus;
  String? password;
  String? cvpath;

  void load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullname = prefs.getString('fullname');
      email = prefs.getString('email');
      dob = prefs.getString('dob');
      mobile = prefs.getString('mobile');
      maritalstatus = prefs.getString('maritalstatus');
      password = prefs.getString('password');
      imagepath = prefs.getString('imagepath');
      cvpath = prefs.getString('cvpath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ListView(
        children: [
          if (fullname != null) Text('Fullname : $fullname'),
          if (password != null) Text('Email : $email'),
          if (imagepath != null) Image.file(File(imagepath!)),
          if (email != null) Text('Email: $email'),
        ],
      ),
    );
  }
}
