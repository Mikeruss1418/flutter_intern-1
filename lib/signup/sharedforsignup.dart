import 'dart:convert';


// import 'package:day5/models/signup_model.dart';
import 'package:day5/signup/signup_model.dart';
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
  Future<void> deleteFirstModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList('model_list');
    if (jsonStringList != null && jsonStringList.isNotEmpty) {
      jsonStringList.removeAt(0); // Remove the first item
      await prefs.setStringList('model_list', jsonStringList);
    }
  }
}
/*import 'package:shared_preferences/shared_preferences.dart';

Future<List<SaveModel>> getSavedModels() async {
  final prefs = await SharedPreferences.getInstance();
  final String? savedModelsJson = prefs.getString('save_models');
  if (savedModelsJson != null) {
    List<dynamic> jsonList = jsonDecode(savedModelsJson);
    return jsonList.map((json) => SaveModel.fromJson(json)).toList();
  }
  return [];
}

Future<void> saveModels(List<SaveModel> models) async {
  final prefs = await SharedPreferences.getInstance();
  final String jsonString = jsonEncode(models.map((model) => model.toJson()).toList());
  await prefs.setString('save_models', jsonString);
}

Future<void> deleteFirstModel() async {
  List<SaveModel> models = await getSavedModels();
  if (models.isNotEmpty) {
    models.removeAt(0);
    await saveModels(models);
  }
}
 */
