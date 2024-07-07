import 'dart:convert';

import 'package:day5/models/for_project.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<void> addUserModel(CvModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('model_list');
    List<CvModel> modelList = [];

    if (jsonStringList != null) {
      modelList = jsonStringList
          .map((jsonString) => CvModel.fromJson(jsonDecode(jsonString)))
          .toList();
    }
    

    modelList.add(userModel);

    List<String> updatedJsonStringList =
        modelList.map((model) => jsonEncode(model.toJson())).toList();

    await prefs.setStringList('model_list', updatedJsonStringList);
  }

  Future<List<CvModel>> getModelList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('model_list');
    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => CvModel.fromJson(jsonDecode(jsonString)))
          .toList();
    } else {
      return [];
    }
  }
}
