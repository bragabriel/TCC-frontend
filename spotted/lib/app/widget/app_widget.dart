import 'package:flutter/material.dart';
import 'package:spotted/app/view/usuario_page/usuarioCadastrar_view.dart';
import 'package:spotted/app/view/usuario_page/perfil_view.dart';
import 'package:spotted/app/view/splash_page/splash_view.dart';
import '../controller/app_controller.dart';
import '../view/alimento_page/alimento_view.dart';
import '../view/emprego_page/emprego_view.dart';
import '../view/evento_page/evento_view.dart';
import '../view/home_page/home_view.dart';
import '../view/login_page/login_view.dart';
import '../view/moradia_page/moradia_view.dart';
import '../view/objeto_page/objeto_view.dart';
import '../view/usuario_page/my_products.dart';
import '../view/transporte_page/transporte_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

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
            '/cadastro': (context) => const CadastroPage(),
            '/perfil': (context) => const ProfilePage(),
            '/transporte': (context) => const TransportePage(),
            '/alimento': (context) => const AlimentoPage(),
            '/emprego': (context) => const EmpregoPage(),
            '/evento': (context) => const EventoPage(),
            '/moradia': (context) => const MoradiaPage(),
            '/objeto': (context) => const ObjetoPage(),
            '/meusprodutos': (context) => const MyProductsPage(),
            '/home': (context) => const HomePage(),
            '/': (context) => const LoginPage(),
          },
        );
      },
    );
  }
}
