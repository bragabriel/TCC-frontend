import 'package:flutter/cupertino.dart';

class AppController extends ChangeNotifier{

  //Singleton para instanciar apenas 1x
  static AppController instance = AppController();

  bool isDartTheme = false;

  //Método
  changeTheme(){
    isDartTheme = !isDartTheme;

    //Notificando quem estiver escutando
    notifyListeners();
  }
}
