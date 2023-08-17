import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:spotted/service/prefs_service.dart';

import '../../../service/change_notifier.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.wait([
      PrefsService.isAuth(),
      Future.delayed(Duration(seconds: 2)),
    ]).then((value) {
      if (value[0]) {
        // Acessar o UserProvider
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);

        // Navegar para a tela home
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Navegar para outra tela
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green.shade900,
        child: Center(
            child: CircularProgressIndicator(
          color: Colors.white60,
        )));
  }
}
