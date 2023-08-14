import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../service/change_notifier.dart';
import '../../controller/usuario_controller.dart';
import '../../model/usuario_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

const String apiKey = 'YOUR_OPENWEATHERMAP_API_KEY';

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
    _fetchWeather();
  }

  String _weatherDescription = '';
  double _temperature = 0.0;

  Future<void> _fetchWeather() async {
    LocationData? locationData;
    final location = Location();
    try {
      locationData = await location.getLocation();
    } catch (e) {
      print('Error getting location: $e');
    }

    if (locationData != null) {
      final lat = locationData.latitude!;
      final lon = locationData.longitude!;
      final url =
          'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherDescription = data['weather'][0]['description'];
          _temperature = data['main']['temp'];
        });
      }
    }
  }

  _body() {
    build(context);
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
                leading: Icon(Icons.food_bank_sharp),
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
              onTap: () async {
                // Limpar as informações do usuário no UserProvider
                Provider.of<UserProvider>(context, listen: false).logout();
                
                SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isAuthenticated', false);
                // Redirecionar o usuário para a tela de login
                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ]),
        ),
        appBar: AppBar(
          title: Text('Página inicial'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'SPOTTED MAIS PROFISSIONAL IMPOSSÍVEL',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Previsão do Tempo:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '$_weatherDescription',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Temperatura: $_temperature°C',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ));
  }
}
