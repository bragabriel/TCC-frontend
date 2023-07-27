import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/change_notifier.dart';
import '../../controller/app_controller.dart';
import '../../controller/usuario_controller.dart';
import '../../model/usuario_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final controller = UsuarioController();

  _success() {
    return _body();
  }

  _error() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ops, algo de errado aconteceu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.start();
            },
            child: Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

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
                leading: Icon(Icons.home_filled),
                title: Text('Moradia'),
                subtitle: Text('Lugares próximos ao campus? 🔑'),
                onTap: () {
                  Navigator.of(context).pushNamed('/moradia');
                }),
            ListTile(
                leading: Icon(Icons.food_bank_outlined),
                title: Text('Objetos Perdidos'),
                subtitle: Text('Perdeu seu casaco favorito? 👀'),
                onTap: () {
                  Navigator.of(context).pushNamed('/objetos');
                }),
            ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Perfil'),
                subtitle: Text('Deixa eu ver a minha beleza 😍'),
                onTap: () {
                  Navigator.of(context).pushNamed('/perfil');
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
          actions: [
            IconButton(
              icon: Icon(Icons.refresh_outlined),
              onPressed: () {
                controller.start();
              },
            )
          ],
        ),
        body: AnimatedBuilder(
          animation: controller.state,
          builder: (context, child) {
            return stateManagement(controller.state.value);
          },
        ));
  }
}

Widget _body() {
  return Container(
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
          ),
        ),
      ],
    ),
  );
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
