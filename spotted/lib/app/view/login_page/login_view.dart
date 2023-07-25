import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/usuario_repository.dart';

import '../../../service/change_notifier.dart';
import '../../model/usuario_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  late Usuario usuario;

//BATER NO ENDPOINT LOGIN
//GET USUARIO SERA NA HOMEPAGE
/* Future<void> _getUsuario(num id) async {
    try {
      final response = await UsuarioRepository().getUsuario(id);
      setState(() {
        this.usuario = response;
      });
    } catch (e) {
      print('Erro ao obter o usuário: $e');
    }
  } */

  Widget _body() {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 300,
                height: 300,
                child: Image.asset('assets/images/logo.png')),
            Container(
              height: 20,
            ),
            Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 20, bottom: 12),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (text) {
                          email = text;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email', border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (text) {
                          password = text;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (email == 'teste' && password == '123') {
                            //Login correto
                            Usuario user = Usuario(
                              idUsuario: 1,
                              nomeUsuario: 'Nome do Usuário',
                              sobrenomeUsuario: 'Sobrenome do Usuário',
                              emailUsuario: email,
                              senhaUsuario: '123',
                              telefoneUsuario: '123456789',
                              dataNascimento: DateTime(2000, 1, 1),
                            );
                            Provider.of<UserProvider>(context, listen: false)
                                .setUser(user);
                            Navigator.of(context).pushReplacementNamed('/home');
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Atenção"),
                                    content:
                                        Text("Login realizado com sucesso!"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                });
                          } else {
                            print('login inválido');
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          child: Text('Entrar', textAlign: TextAlign.center),
                        ),
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/cadastro');
              },
              child: Text(
                'Novo aqui? Cadastre-se',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/recuperarSenha');
              },
              child: Text(
                'Problemas com login? Clique aqui.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/wallpaper.png',
              fit: BoxFit.cover,
            )),
        Container(color: Colors.black.withOpacity(0.3)),
        _body(),
      ],
    ));
  }
}
