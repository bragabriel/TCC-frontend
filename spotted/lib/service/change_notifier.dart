import 'package:flutter/foundation.dart';
import '../app/model/alimento_model.dart';
import '../app/model/usuario_model.dart';

class UserProvider with ChangeNotifier {
  Usuario? _user;
  bool _isAuthenticated = false;

  Usuario? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  void setUser(Usuario user) {
    _user = user;
    _isAuthenticated = true;
    notifyListeners();
  }

  void updateUserInfo(Usuario newUser) {
    _user = newUser;
    print("chegou aqui");
    print(newUser);
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
