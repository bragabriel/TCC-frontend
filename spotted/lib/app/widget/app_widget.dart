import 'package:flutter/material.dart';
import 'package:spotted/app/view/alimento_page/alimento_view.dart';
import 'package:spotted/app/view/cadastro_page/cadastro_view.dart';
import 'package:spotted/app/view/profile_page/perfil_view.dart';
import '../controller/app_controller.dart';
import '../view/emprego_page/emprego_view.dart';
import '../view/festa_page/festa_view.dart';
import '../view/home_page/home_view.dart';
import '../view/login_page/login_view.dart';
import '../view/moradia_page/moradia_view.dart';
import '../view/objeto_view/objeto_view.dart';
import '../view/transporte_page/transporte_view.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,

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
            '/transporte': (context) => TransportePage(),
            '/alimento': (context) => AlimentoPage(),
            '/emprego': (context) => EmpregoPage(),
            '/festa': (context) => FestaPage(),
            '/moradia': (context) => MoradiaPage(),
            '/objeto': (context) => ObjetoPage(),
            '/home': (context) => HomePage(),
            '/': (context) => LoginPage(),
          },
        );
      },
    );
  }
}
