import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'package:spotted/service/prefs_service.dart';

import '../../../service/user_provider.dart';

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
      Future.delayed(const Duration(seconds: 2)),
    ]).then((value) async {
      if (value[0]) {
        // Acessar o UserProvider
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);

        Usuario usuario = await PrefsService.getUser();
        userProvider.setUser(usuario);

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
        child: const Center(
            child: CircularProgressIndicator(
          color: Colors.white60,
        )));
  }
}
