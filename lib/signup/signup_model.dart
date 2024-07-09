import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class SaveModel {
  String? fullname;
  String? gender;
  String? email;
  String? imagebase64;
  String? dob;
  String? mobile;
  String? maritalstatus;
  String? password;
  String? cvpath;

  SaveModel(
      {this.cvpath,
      this.gender,
      this.dob,
      this.email,
      this.fullname,
      this.imagebase64,
      this.maritalstatus,
      this.mobile,
      this.password});

  SaveModel.fromJson(Map<String, dynamic> map) {
    fullname = map['fullname'];
    gender = map['gender'];
    email = map['email'];
    imagebase64 = map['imagebase64'];
    dob = map['dob'];
    mobile = map['mobile'];
    maritalstatus = map['maritialstatus'];
    password = map['password'];
    cvpath = map['cvpath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['gender'] = gender;
    data['email'] = email;
    data['imagebase64'] = imagebase64;
    data['dob'] = dob;
    data['mobile'] = mobile;
    data['maritialstatus'] = maritalstatus;
    data['password'] = password;
    data['cvpath'] = cvpath;
    return data;
  }

  ImageProvider getImageProvider() {
    if (imagebase64 != null) {
      Uint8List bytes = base64Decode(imagebase64!);
      return MemoryImage(bytes);
    } else {
      return const AssetImage('asset/images/test.jpg');
    }
  }
}
