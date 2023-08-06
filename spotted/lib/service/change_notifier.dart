import 'package:flutter/foundation.dart';

import '../app/model/usuario_model.dart';

class UserProvider with ChangeNotifier {
  Usuario? _user;

  Usuario? get user => _user;

  void setUser(Usuario user) {
    _user = user;
    notifyListeners();
  }

  void updateUserInfo(Usuario newUser) {
    _user = newUser;
    notifyListeners();
  }
}