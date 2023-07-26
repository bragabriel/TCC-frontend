import 'package:flutter/foundation.dart';

import '../app/model/usuario_model.dart';

class UserProvider extends ChangeNotifier {
  Usuario? _user;

  Usuario? get user => _user;

  void setUser(Usuario user) {
    _user = user;
    notifyListeners();
  }
}