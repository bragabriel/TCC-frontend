import 'dart:convert';
import 'package:spotted/app/model/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static Usuario myUser = Usuario(
    idUsuario: 1,
    dataNascimento: DateTime(2021, 9, 7, 17, 30),
    //dataNascimento: "asdasddas",
    fileName: "",
    url:
        "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
    nomeUsuario: "asd",
    sobrenomeUsuario: 'puardaaspdiasodi',
    //senhaUsuario: 'asjdhasjkdh',
    emailUsuario: 'puxar-da-api',
    telefoneUsuario: '1999999 puxar da api',
  );

  static dynamic init() async =>
      _preferences = await SharedPreferences.getInstance();

  static dynamic setUser(Usuario user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static Usuario getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : Usuario.fromJson(jsonDecode(json));
  }
}
