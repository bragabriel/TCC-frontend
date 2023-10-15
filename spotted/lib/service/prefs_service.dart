import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/model/usuario_model.dart';

class PrefsService {
  static const String _key = 'key';
  static const String _userSaved = 'userSaved';

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

  static getUser() async {
    var prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_userSaved);

    if (jsonString != null) {
/*       var teste = Usuario.fromJson(json.decode(jsonString)); */
 /*      print('a?');
      print(teste.nomeUsuario); */
      return Usuario.fromJson(json.decode(jsonString));
    } else {
      return null;
    }
  }
}
