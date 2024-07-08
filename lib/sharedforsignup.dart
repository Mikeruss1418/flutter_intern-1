import 'dart:convert';

import 'package:day5/models/for_project.dart';
import 'package:day5/models/signup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  Future<void> addUserModel(SaveModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('model_list');
    List<SaveModel> saveList = [];

    if (jsonStringList != null) {
      saveList = jsonStringList
          .map((jsonString) => SaveModel.fromJson(jsonDecode(jsonString)))
          .toList();
    }

    saveList.add(userModel);

    List<String> updatedJsonStringList =
        saveList.map((model) => jsonEncode(model.toJson())).toList();

    await prefs.setStringList('model_list', updatedJsonStringList);
  }

  Future<List<SaveModel>> getModelList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('model_list');
    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => SaveModel.fromJson(jsonDecode(jsonString)))
          .toList();
    } else {
      return [];
    }
  }
}
