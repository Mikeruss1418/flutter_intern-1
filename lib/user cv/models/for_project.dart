




import 'package:day5/user%20cv/models/exp_model.dart';
import 'package:day5/user%20cv/models/other_model.dart';

class CvModel {
  String? fname;
  String? mname;
  String? lname;
  String? age;
  String? gender;
  String? college;
  String? acheivement;
  String? level;
  String? sdate;
  String? edate;
  List<dynamic>? skills;
  List<ExpModel>? exlist;
  List<OthersModel>? otlist;
  List<dynamic>? languages;
  List<dynamic>? interest;

  CvModel(
      {this.fname,
      this.mname,
      this.lname,
      this.age,
      this.gender,
      this.college,
      this.acheivement,
      this.sdate,
      this.edate,
      this.level,
      this.skills,
      this.exlist,
      this.otlist,
      this.languages,
      this.interest});

  CvModel.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    mname = json['mname'];
    lname = json['lname'];
    gender = json['gender'];
    age = json['age'];
    college = json['college'];
    acheivement = json['achievement'];
    sdate = json['sdate'];
    edate = json['edate'];
    level = json['level'];
    skills = json['skills'];
    languages = json['languages'];
    interest = json['interest'];

    exlist = (json['exlist'] as List<dynamic>?)
        ?.map((exp) => ExpModel.fromJson(exp))
        .toList();
    // (json['exlist'] != null ? ExpModel.fromJson(json['exlist']) : null);
    otlist = (json['otlist'] as List<dynamic>?)
        ?.map((e) => OthersModel.fromJson(e))
        .toList();
    // (json['otlist'] != null ? OthersModel.fromJson(json['otlist']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['fname'] = fname;
    map['mname'] = mname;
    map['lname'] = lname;
    map['age'] = age;
    map['level'] = level;
    map['college'] = college;
    map['achievement'] = acheivement;
    map['sdate'] = sdate;
    map['edate'] = edate;

    map['skills'] = skills;
    map['gender'] = gender;
    map['languages'] = languages;
    map['interest'] = interest;
    if (exlist != null) {
      map['exlist'] = exlist!.map((e) => e.toJson()).toList();
    }
    if (otlist != null) {
      map['otlist'] = otlist!.map((e) => e.toJson()).toList();
    }

    return map;
  }
}

// class Exlist {
//   String? job;
//   String? summary;
//   String? comapny;

//   Exlist({this.job, this.summary, this.comapny});

//   Exlist.fromJson(Map<String, dynamic> json) {
//     job = json['job'];
//     summary = json['summary'];
//     comapny = json['comapny'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = <String, dynamic>{};
//     map['job'] = job;
//     map['summary'] = summary;
//     map['comapny'] = comapny;
//     return map;
//   }
// }

//   factory Project.fromJson(Map<String, dynamic> json) {
//     //retriving list of experience/otherproject json obj from 'exlist'/'olist' key in json map
//     var exlistfromJson = json['exlist'] as List;
//     var olistfromJson = json['olist'] as List;
//     //converting each json onj in the list to an OthersModel instances
//     List<OthersModel> otlist = olistfromJson.map((otListJson) {
//       return OthersModel.fromJson(
//           otListJson); //call OthersModel.fromJson for each
//     }).toList();
//     List<ExpModel> explist = exlistfromJson.map((explistJson) {
//       return ExpModel.fromJson(explistJson);
//     }).toList();
//     return Project(
//       fname: json['fname'],
//       mname: json['mname'],
//       lname: json['lname'],
//       age: json['age'],
//       exlist: explist,
//       olist: otlist,
//     );
//   }
// }
// class Project {
//   String? fname;
//   String? mname;
//   String? lname;
//   int? age;
//   Exlist? exlist;
//   String? college;
//   String? sdate;
//   String? edate;
//   Olist? olist;

//   Project(
//       {this.fname,
//       this.mname,
//       this.lname,
//       this.age,
//       this.exlist,
//       this.college,
//       this.sdate,
//       this.edate,
//       this.olist});

//   Project.fromJson(Map<String, dynamic> json) {
//     fname = json['fname'];
//     mname = json['mname'];
//     lname = json['lname'];
//     age = json['age'];
//     exlist =
//         json['exlist'] != null ? new Exlist.fromJson(json['exlist']) : null;
//     college = json['college'];
//     sdate = json['sdate'];
//     edate = json['edate'];
//     olist = json['olist'] != null ? new Olist.fromJson(json['olist']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = new Map<String, dynamic>();
//     map['fname'] = this.fname;
//     map['mname'] = this.mname;
//     map['lname'] = this.lname;
//     map['age'] = this.age;
//     if (this.exlist != null) {
//       map['exlist'] = this.exlist!.toJson();
//     }
//     map['college'] = this.college;
//     map['sdate'] = this.sdate;
//     map['edate'] = this.edate;
//     if (this.olist != null) {
//       map['olist'] = this.olist!.toJson();
//     }
//     return map;
//   }
// }

// class Exlist {
//   String? job;
//   String? summary;
//   String? company;
//   String? sedate;
//   String? eedate;

//   Exlist({this.job, this.summary, this.company, this.sedate, this.eedate});

//   Exlist.fromJson(Map<String, dynamic> json) {
//     job = json['job'];
//     summary = json['summary'];
//     company = json['company'];
//     sedate = json['sedate'];
//     eedate = json['eedate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = new Map<String, dynamic>();
//     map['job'] = this.job;
//     map['summary'] = this.summary;
//     map['company'] = this.company;
//     map['sedate'] = this.sedate;
//     map['eedate'] = this.eedate;
//     return map;
//   }
// }

// class Olist {
//   String? project;
//   String? desciption;
//   String? sdate;
//   String? edate;

//   Olist({this.project, this.desciption, this.sdate, this.edate});

//   Olist.fromJson(Map<String, dynamic> json) {
//     project = json['project'];
//     desciption = json['Desciption'];
//     sdate = json['sdate'];
//     edate = json['edate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> map = new Map<String, dynamic>();
//     map['project'] = this.project;
//     map['Desciption'] = this.desciption;
//     map['sdate'] = this.sdate;
//     map['edate'] = this.edate;
//     return map;
//   }
// }
