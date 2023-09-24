import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:provider/provider.dart';
import 'package:spotted/service/prefs_service.dart';
import '../../../service/change_notifier.dart';
import '../../constants/constants.dart';
import '../../controller/usuario_controller.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/descriptions_model.dart';
import '../../model/usuario_model.dart';
import 'details_view.dart';

const String apiKey = '3dbbf29cb72728e380272e98fe760b41';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final controller = UsuarioController();
  Usuario? _usuario;

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
              controller.start(context);
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
    controller.start(context);
  }

  Future<void> getUserPreferences() async {
    PrefsService sharedPref = PrefsService();

    // Acessar a instância do UserProvider
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    var userData = await sharedPref.getUser();
    if (userData != null) {
      userProvider.updateUserInfo(userData);
    }
  }

  _body() {
    return build(context);
  }

  @override
  Widget build(BuildContext context) {
    getUserPreferences();

    Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        _usuario = UsuarioHelper.getUser(context, userProvider);
        return Container();
      },
    );

    return Scaffold(
      drawer: Drawer(
        child: Column(children: [
          // aqui pegar usuario
          Consumer<UserProvider>(
            builder: (context, userProvider, _) {
              return buildUserDrawerHeader(context, userProvider);
            },
          ),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text('Alimentos'),
            subtitle: Text('Ai que fominha! 🍽'),
            onTap: () {
              Navigator.of(context).pushNamed('/alimento');
            },
          ),
          ListTile(
            leading: Icon(Icons.business_center),
            title: Text('Empregos'),
            subtitle: Text('Bora trabalhar? 💻'),
            onTap: () {
              Navigator.of(context).pushNamed('/emprego');
            },
          ),
          ListTile(
            leading: Icon(Icons.local_bar),
            title: Text('Eventos'),
            subtitle: Text('Partiu pra revoada? 🎉'),
            onTap: () {
              Navigator.of(context).pushNamed('/evento');
            },
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text('Moradia'),
            subtitle: Text('Lugares próximos ao campus? 🔑'),
            onTap: () {
              Navigator.of(context).pushNamed('/moradia');
            },
          ),
          ListTile(
            leading: Icon(Icons.food_bank_sharp),
            title: Text('Objetos Perdidos'),
            subtitle: Text('Perdeu seu casaco favorito? 👀'),
            onTap: () {
              Navigator.of(context).pushNamed('/objeto');
            },
          ),
          ListTile(
            leading: Icon(Icons.car_crash),
            title: Text('Transportes'),
            subtitle: Text('Naves para ir à faculdade? 🚗'),
            onTap: () {
              Navigator.of(context).pushNamed('/transporte');
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Perfil'),
            subtitle: Text('Deixa eu ver meus dados 😍'),
            onTap: () {
              Navigator.of(context).pushNamed('/perfil');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            subtitle: Text('Finalizar sessão'),
            onTap: () async {
              // Limpar as informações do usuário no UserProvider
              Provider.of<UserProvider>(context, listen: false).logout();

              PrefsService.logout();

              // Redirecionar o usuário para a tela de login
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => true);
            },
          )
        ]),
      ),
      appBar: AppBar(
        title: Text('Página inicial'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientEndColor, gradientStartColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(32),
                child: Column(children: <Widget>[
                  Row(
                    children: [
                      Text(
                        'Olá fulano de tal!',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 40,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Text(
                    'O que oferecemos:',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 24,
                        color: Color(0x7cdbf1ff),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ]),
              ),
              Expanded(
                child: SizedBox(
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Swiper(
                      itemCount: planets.length,
                      fade: 0.3,
                      itemWidth: MediaQuery.of(context).size.width - 2 * 69,
                      layout: SwiperLayout.STACK,
                      pagination: const SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          activeSize: 20,
                          activeColor: Colors.black,
                          space: 5,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (context, a, b) => DetailsView(
                                    artefatoInfo: planets[index],
                                  ),
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                      Widget child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ));
                          },
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    elevation: 8,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 100,
                                          ),
                                          Text(
                                            planets[index].name.toString(),
                                            style: const TextStyle(
                                              fontSize: 21,
                                              fontFamily: 'Avenir',
                                              color: Color(0xff47455f),
                                              fontWeight: FontWeight.w900,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 32.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Saber mais",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Avenir',
                                                    color: secondaryTextColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  color: secondaryTextColor,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Hero(
                                tag: planets[index].position,
                                child: Image.asset(
                                  planets[index].iconImage.toString(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildFotoPerfil(String? perfil) {
  if (perfil != null) {
    return Center(
      child: Image.network(perfil),
    );
  } else {
    return Center(
      child: Image.asset('assets/images/perfil.png'),
    );
  }
}

Widget buildUserDrawerHeader(BuildContext context, UserProvider userProvider) {
  Usuario? user = userProvider.user;

  return UserAccountsDrawerHeader(
    currentAccountPicture: ClipPath(
      child: _buildFotoPerfil(user?.url),
    ),
    accountName: Text(user?.nomeUsuario ?? 'Usuário não logado'),
    accountEmail: Text(user?.emailUsuario ?? ''),
  );
}
