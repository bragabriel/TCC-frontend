import 'package:flutter/cupertino.dart';
import '../../service/change_notifier.dart';
import '../model/usuario_model.dart';

class UsuarioHelper {
  static Usuario? getUser(BuildContext context, UserProvider userProvider) {
    Usuario? user = userProvider.user;
    return user;
  }
}
