import 'package:flutter/material.dart';
import 'package:spotted/app/view/cadastro_page/cadastro_view.dart';
import 'package:spotted/app/view/profile_page/perfil_view.dart';
import 'package:spotted/app/view/splash_page/splash_view.dart';
import '../controller/app_controller.dart';
import '../view/alimento_page/alimento_view.dart';
import '../view/emprego_page/emprego_view.dart';
import '../view/evento_page/evento_view.dart';
import '../view/home_page/home_view.dart';
import '../view/login_page/login_view.dart';
import '../view/moradia_page/moradia_view.dart';
import '../view/objeto_view/objeto_view.dart';
import '../view/profile_page/my_products.dart';
import '../view/transporte_page/transporte_view.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            brightness: AppController.instance.isDartTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashPage(),
            '/cadastro': (context) => CadastroPage(),
            '/perfil': (context) => ProfilePage(),
            '/transporte': (context) => TransportePage(),
            '/alimento': (context) => AlimentoPage(),
            '/emprego': (context) => EmpregoPage(),
            '/evento': (context) => EventoPage(),
            '/moradia': (context) => MoradiaPage(),
            '/objeto': (context) => ObjetoPage(),
            '/meusprodutos': (context) => MyProductsPage(),
            '/home': (context) => HomePage(),
            '/': (context) => LoginPage(),
          },
        );
      },
    );
  }
}