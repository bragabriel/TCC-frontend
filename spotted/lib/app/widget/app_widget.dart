import 'package:flutter/material.dart';
import 'package:spotted/app/view/alimento_page/alimento_view.dart';
import 'package:spotted/app/view/cadastro_page/cadastro_view.dart';
import 'package:spotted/app/view/emprego_page/emprego_view.dart';
import 'package:spotted/app/view/moradia_view/moradia_view.dart';
import 'package:spotted/app/view/profile_page/perfil_view.dart';
import '../controller/app_controller.dart';
import '../view/home_page/home_view.dart';
import '../view/login_page/login_view.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,

            //Se for true, retorna o dark.
            //Se for false, retorna o light
            brightness: AppController.instance.isDartTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          initialRoute: '/',
          routes: {
            '/cadastro': (context) => CadastroPage(),
            '/perfil': (context) => ProfilePage(),
            // '/transporte': (context) => TransportePage(),
            '/comida': (context) => AlimentoPage(),
            '/emprego': (context) => EmpregoPage(),
            // '/festa': (context) => FestaPage(),
            '/moradia': (context) => MoradiaPage(),
            '/home': (context) => HomePage(),
            '/': (context) => LoginPage(),
          },
        );
      },
    );
  }
}
