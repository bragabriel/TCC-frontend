import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotted/app/view/alimento_page/alimento_view.dart';
import 'package:spotted/app/view/cadastro_page/cadastro_view.dart';
import 'package:spotted/app/view/profile_page/perfil_view.dart';
import '../../service/change_notifier.dart';
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
          return FutureBuilder<bool>(
            future: _checkAuthentication(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Aguarde até verificar a autenticação
              }

              // Verificar se o usuário está autenticado
              final isAuthenticated =
                  Provider.of<UserProvider>(context).isAuthenticated;

              return MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.lightGreen,
                  brightness: AppController.instance.isDartTheme
                      ? Brightness.dark
                      : Brightness.light,
                ),
                // Definir a tela inicial com base na autenticação
                initialRoute: isAuthenticated ? '/home' : '/',

                routes: {
                  '/cadastro': (context) => CadastroPage(),
                  '/perfil': (context) =>
                      isAuthenticated ? ProfilePage() : LoginPage(),
                  '/comida': (context) =>
                      isAuthenticated ? AlimentoPage() : LoginPage(),
                  '/emprego': (context) =>
                      isAuthenticated ? EmpregoPage() : LoginPage(),
                  '/moradia': (context) =>
                      isAuthenticated ? MoradiaPage() : LoginPage(),
                  '/home': (context) =>
                      isAuthenticated ? HomePage() : LoginPage(),
                  '/': (context) => LoginPage(),
                },
              );
            },
          );
        });
  }

  Future<bool> _checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated') ?? false;
  }
}
