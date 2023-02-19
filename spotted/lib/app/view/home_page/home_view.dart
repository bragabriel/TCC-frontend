//StatefulWidget = Dinamico -> Pode ser modificado
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/app_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

//Criando uma classe para ser retornada e funcionar como um estado
class HomePageState extends State<HomePage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
              currentAccountPicture:
                  //ClipRRect(
                  ClipOval(
                      //borderRadius: BorderRadius.circular(30),
                      child: Image.asset('assets/images/user.png')),
              accountName: Text('Gabriel Braga'),
              accountEmail: Text('teste@teste.com')),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              subtitle: Text('tela de inicio'),
              onTap: () {
                print('home');
              }),
          ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Perfil'),
              subtitle: Text('seu perfil'),
              onTap: () {
                Navigator.of(context).pushNamed('/perfil');
              }),
          ListTile(
              leading: Icon(Icons.ads_click),
              title: Text('Teste'),
              subtitle: Text('teste req get api'),
              onTap: () {
                Navigator.of(context).pushNamed('/teste');
              }),
          ListTile(
              leading: Icon(Icons.food_bank_outlined),
              title: Text('Comida'),
              subtitle: Text('encontre vendedores de gostosuras pelo campus'),
              onTap: () {
                Navigator.of(context).pushNamed('/comida');
              }),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              subtitle: Text('Finalizar sessão'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
        ]),
      ),
      appBar: AppBar(
        title: Text('Home Page'),

        //botões que ficam na lateral direita
        actions: [
          CustomSwitch(),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: PageView(
          children: [
            Container(
              height: 150,
              color: Colors.redAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Contador: $counter'),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Bem-Vindo!',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 50,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.blue[700]!,
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          color: Colors.cyan,
                          child: Text(
                            'ARRASTA',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          color: Colors.green,
                          child: Text(
                            'PARA',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          color: Colors.orange,
                          child: Text(
                            'O',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ]),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'O melhor TCC da FHO!',
                      style: TextStyle(
                          fontSize: 40,
                          foreground: Paint()
                            ..shader = ui.Gradient.linear(
                              const Offset(0, 20),
                              const Offset(150, 20),
                              <Color>[
                                Colors.red,
                                Colors.yellow,
                              ],
                            )),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          color: Color.fromARGB(255, 110, 110, 110),
                          child: Text(
                            'LADO',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          color: Colors.pink,
                          child: Text(
                            'E',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          color: Colors.purple,
                          child: Text(
                            'DIVIRTA-SE',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            Container(
              height: 150,
              color: Colors.orange,
              child: Container(
                padding: EdgeInsets.all(25.0),
                child: Text('COMIDAS',
                style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                )),
              ), 
            ),
            Container(
              height: 150,
              color: Colors.green,
              child: Text('APÊS'),
            ),
            Container(
              height: 150,
              color: Colors.blue,
              child: Text('CARONAS'),
            ),
            Container(
              height: 150,
              color: Colors.pink,
              child: Text('COMIDAS'),
            ),
            Container(
              height: 150,
              color: Colors.purple,
              child: Text('ESTÁGIOS'),
            ),
            Container(
              height: 150,
              color: Colors.yellow,
              child: Text('FESTAS'),
            ),
            Container(
              height: 150,
              color: Colors.blue,
              child: Text('ACHADOS/PERDIDOS'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            counter++; //necessario dizer que o estado vai ser modificado e precisa ser reconstuido
          });
        },
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: AppController.instance.isDartTheme,
        onChanged: (value) {
          AppController.instance.changeTheme();
        });
  }
}
