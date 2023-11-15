import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:provider/provider.dart';
import 'package:spotted/service/prefs_service.dart';
import '../../../service/user_provider.dart';
import '../../constants/constants.dart';
import '../../controller/usuario_controller.dart';
import '../../model/descriptions_model.dart';
import '../../model/usuario_model.dart';
import 'details_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
          const Text(
            'Ops, algo de errado aconteceu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.start(context);
            },
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  _loading() {
    return const Center(child: CircularProgressIndicator());
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

  _body() {
    return build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                return buildUserDrawerHeader(context, userProvider);
              },
            ),
            ListTile(
              leading: const Icon(Icons.food_bank),
              title: const Text('Alimentos'),
              subtitle: const Text('Opções de comidas 🍕'),
              onTap: () {
                Navigator.of(context).pushNamed('/alimento');
              },
            ),
            ListTile(
              leading: const Icon(Icons.business_center),
              title: const Text('Empregos'),
              subtitle: const Text('Buscar trabalhos 💻'),
              onTap: () {
                Navigator.of(context).pushNamed('/emprego');
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_bar),
              title: const Text('Eventos'),
              subtitle: const Text('Festas e eventos 🎉'),
              onTap: () {
                Navigator.of(context).pushNamed('/evento');
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: const Text('Moradia'),
              subtitle: const Text('Um novo lar? 🔑'),
              onTap: () {
                Navigator.of(context).pushNamed('/moradia');
              },
            ),
            ListTile(
              leading: const Icon(Icons.food_bank_sharp),
              title: const Text('Objetos Perdidos'),
              subtitle: const Text('Perdeu seu casaco favorito? 👀'),
              onTap: () {
                Navigator.of(context).pushNamed('/objeto');
              },
            ),
            ListTile(
              leading: const Icon(Icons.car_crash),
              title: const Text('Transportes'),
              subtitle: const Text('Carona, ônibus ou van? 🚗'),
              onTap: () {
                Navigator.of(context).pushNamed('/transporte');
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Perfil'),
              subtitle: const Text('Dados e cadastros 👤'),
              onTap: () {
                Navigator.of(context).pushNamed('/perfil');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              subtitle: const Text('Finalizar sessão'),
              onTap: () async {
                Provider.of<UserProvider>(context, listen: false).logout();
                PrefsService.logout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => true);
              },
            )
          ]),
        ),
        appBar: AppBar(
          title: const Text('Página inicial'),
        ),
        body: Consumer<UserProvider>(builder: (context, userProvider, _) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [gradientEndColor, gradientStartColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(children: <Widget>[
                      Text(
                        "Olá ${userProvider.user?.nomeUsuario ?? 'Usuário não logado'}!",
                        style: const TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 40,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'O que oferecemos:',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            color: Color(0x7cdbf1ff),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Swiper(
                          itemCount: artefatos.length,
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
                                      pageBuilder: (context, a, b) =>
                                          DetailsView(
                                        artefatoInfo: artefatos[index],
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
                                          borderRadius:
                                              BorderRadius.circular(32),
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
                                                artefatos[index]
                                                    .name
                                                    .toString(),
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
                                                        color:
                                                            secondaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_rounded,
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
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Hero(
                                      tag: artefatos[index].position,
                                      child: Image.asset(
                                        artefatos[index].iconImage.toString(),
                                        width: 200,
                                        height: 200,
                                      ),
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
          );
        }));
  }
}

Widget buildUserDrawerHeader(BuildContext context, UserProvider userProvider) {
  Usuario? user = userProvider.user;

  Widget buildFotoPerfil(String? imageUrl) {
    if (imageUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: 40,
      );
    } else {
      return const CircleAvatar(
        radius: 30,
        child: Icon(Icons.person, size: 40),
      );
    }
  }

  return UserAccountsDrawerHeader(
    currentAccountPicture: buildFotoPerfil(user?.url),
    accountName: Text(user?.nomeUsuario ?? 'Usuário não logado'),
    accountEmail: Text(user?.emailUsuario ?? ''),
  );
}
