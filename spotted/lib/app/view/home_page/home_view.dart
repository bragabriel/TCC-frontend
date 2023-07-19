//StatefulWidget = Dinamico -> Pode ser modificado
import 'package:flutter/material.dart';

import '../../controller/app_controller.dart';
import '../alimento_page/alimento_view.dart';
import '../emprego_page/job_home.dart';
import '../emprego_page/postjobs_view.dart';

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
              leading: Icon(Icons.verified_user),
              title: Text('Perfil'),
              subtitle: Text('Deixa eu ver a minha beleza 😍'),
              onTap: () {
                Navigator.of(context).pushNamed('/perfil');
              }),
          ListTile(
              leading: Icon(Icons.car_crash_outlined),
              title: Text('Transportes'),
              subtitle: Text('Transportes mais economicos? 💸'),
              onTap: () {
                Navigator.of(context).pushNamed('/comida');
              }),
          ListTile(
              leading: Icon(Icons.food_bank_outlined),
              title: Text('Alimentos'),
              subtitle: Text('Ai que fominha! 🍽'),
              onTap: () {
                Navigator.of(context).pushNamed('/comida');
              }),
          ListTile(
              leading: Icon(Icons.business_center_outlined),
              title: Text('Empregos'),
              subtitle: Text('Bora trabalhar? 💻'),
              onTap: () {
                Navigator.of(context).pushNamed('/emprego');
              }),
          ListTile(
              leading: Icon(Icons.local_bar_outlined),
              title: Text('Festas'),
              subtitle: Text('Partiu pra revoada? 🎉'),
              onTap: () {
                /* Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PostsPageJobs();
                    },
                  ),
                ); */
              }),
          ListTile(
              leading: Icon(Icons.food_bank_outlined),
              title: Text('Moradia'),
              subtitle: Text('Espiadinha em lugares próximos ao campus? 👀'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AlimentoPage(); //MUDAR AQUI
                    },
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Moradia'),
              subtitle: Text('Lugares próximos ao campus? 🔑'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AlimentoPage();
                    },
                  ),
                );
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
        title: Text('Pagina inicial'),
        //botões que ficam na lateral direita
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: PageView(
          children: [
            Container(
              height: 150,
              color: Colors.lightBlueAccent,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: []),
            ),
            // Navigator(
            //   initialRoute: 'home/foodpage',
            // ),
            Container(
              height: 150,
              color: Colors.orange,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AlimentoPage();
                      },
                    ),
                  );
                },
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
