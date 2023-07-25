//StatefulWidget = Dinamico -> Pode ser modificado
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/change_notifier.dart';
import '../../controller/app_controller.dart';
import '../../model/usuario_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: [
          Consumer<UserProvider>(
          builder: (context, userProvider, _) {
              Usuario? user = userProvider.user;
              return UserAccountsDrawerHeader(
                currentAccountPicture: ClipOval(
                  child: Image.asset('assets/images/user.png'),
                ),
                accountName: Text(user?.nomeUsuario ?? 'Usuário não logado'),
                accountEmail: Text(user?.emailUsuario ?? ''),
              );
            },
          ),
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
                Navigator.of(context).pushNamed('/festas');
              }),
          ListTile(
              leading: Icon(Icons.food_bank_outlined),
              title: Text('Objetos Perdidos'),
              subtitle: Text('Perdeu seu casaco favorito? 👀'),
              onTap: () {
                Navigator.of(context).pushNamed('/objetos');
              }),
          ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Moradia'),
              subtitle: Text('Lugares próximos ao campus? 🔑'),
              onTap: () {
                Navigator.of(context).pushNamed('/moradia');
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
