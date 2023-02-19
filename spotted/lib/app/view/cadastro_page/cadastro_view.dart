import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String user = '';

  Widget _body() {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/logo.png')),
            Container(
              height: 20,
            ),
            Card(
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 20, bottom: 12),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (text) {
                          user = text;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'User',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                        height: 10,
                      ),
                      TextField(
                        onChanged: (text) {
                          confirmPassword = text;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Confirm your Password',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (email == 'teste@teste.com' && password == '123') {
                            //Login correto
                            Navigator.of(context).pushReplacementNamed('/home');
                          } else {
                            print('login inválido');
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          child: Text('Cadastrar', textAlign: TextAlign.center),
                        ),
                        style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrangeAccent)),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Text(
                'Já tem uma conta? Logar.',
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
      //Vai para trás, como um background
      children: [
        SizedBox(
            height: MediaQuery.of(context)
                .size
                .height, //pegando o tamanho da tela em si

            child: Image.asset(
              'assets/images/wallpaper.png',
              fit: BoxFit.cover,
            )),
        Container(
            color: Colors.black.withOpacity(0.3)), //diminuindo a opacidade
        _body(),
      ],
    ));
  }
}
