import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/usuario_repository.dart';
import 'package:spotted/app/view/usuario_page/usuarioAtualizar_view.dart';
import '../../../service/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FilledButton _myIconButton;
  final UsuarioRepository usuarioRepository = UsuarioRepository();

  @override
  void initState() {
    super.initState();
    _myIconButton = FilledButton(
      onPressed: () => Navigator.of(context).pushNamed('/meusprodutos'),
      child: const Text("Meus produtos"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ClipOval(
                      child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.network(userProvider.user!.url!)),
                    ),
                    const SizedBox(
                      height: 50,
                      width: 50,
                    ),
                    buildUserInfoDisplay(
                      "${userProvider.user?.nomeUsuario} ${userProvider.user?.sobrenomeUsuario}",
                      'Nome completo',
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateProfilePage(userProvider.user!)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20),
                          ),
                        ),
                        child: const Text('Alterar Informações'),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    _myIconButton,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildUserInfoDisplay(String? getValue, String title) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      getValue!,
                      style: const TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
