import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotted/service/change_notifier.dart';

import '../app/model/usuario_model.dart';

class PrefsService {
  static final String _key = 'key';
  static final String _userSaved = 'userSaved';

  static save(String user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode({"user": user, "isAuth": true}));
  }

  static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.getString(_key);

    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);

      return mapUser['isAuth'];
    }
    return false;
  }

  static logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static saveUser(Usuario user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_userSaved, jsonEncode(user));
  }

  getUser() async {
    var prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_userSaved);

    if (jsonString != null) {
      return Usuario.fromJson(json.decode(jsonString));
    } else {
      return null;
    }
  }
}
