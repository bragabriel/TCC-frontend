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
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        Usuario usuario = await PrefsService.getUser();
        userProvider.setUser(usuario);
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
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
