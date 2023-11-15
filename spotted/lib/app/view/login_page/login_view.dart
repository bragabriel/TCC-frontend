import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/usuario_repository.dart';
import '../../../service/user_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.withOpacity(0.8),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 400,
                      height: 400,
                      child: Image.asset('assets/images/LogoTcc.png')),
                  Container(
                    height: 20,
                  ),
                  Card(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 20, bottom: 12),
                      child: Column(children: [
                        TextField(
                          onChanged: (text) {
                            email = text;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: 'Email', border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          onChanged: (text) {
                            password = text;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await _logar();
                          },
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text('Entrar', textAlign: TextAlign.center),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/cadastro');
                          },
                          child: const Text(
                            'Novo aqui? Cadastre-se',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            )));
  }

  Future<void> _logar() async {
    final response = await UsuarioRepository().logarUsuario(email, password);

    if (response.statusCode == 200) {
      Usuario user = Usuario(
          idUsuario: response.usuario!.idUsuario,
          nomeUsuario: response.usuario!.nomeUsuario,
          sobrenomeUsuario: response.usuario!.sobrenomeUsuario,
          emailUsuario: email,
          senhaUsuario: password,
          telefoneUsuario: response.usuario!.telefoneUsuario,
          listaArtefatosReponse: response.usuario!.listaArtefatosReponse,
          url: response.usuario!.url);

      Provider.of<UserProvider>(context, listen: false).setUser(user);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Atenção"),
            content: const Text("Login realizado com sucesso!"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text("OK"),
              )
            ],
          );
        },
      );
    } else if (response.statusCode == 400) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Atenção"),
              content: const Text("Credenciais inválidas."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            );
          });
    } else {
      throw ("Ocorreu um erro inesperado");
    }
  }
}
