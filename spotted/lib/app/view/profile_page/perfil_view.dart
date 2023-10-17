import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/profile_page/edit_image.dart';
import 'package:spotted/app/view/profile_page/updateEmail.dart';
import 'package:spotted/app/view/profile_page/updateNome.dart';
import 'package:spotted/app/view/profile_page/updateTelefone.dart';
import 'package:spotted/app/widget/display_image_widget.dart';
import '../../../service/user_provider.dart';
import '../../model/usuario_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late IconButton _myIconButton; // Declare _myIconButton como uma variável

  @override
  void initState() {
    super.initState();
    _myIconButton = IconButton(
      icon: Icon(Icons.list, color: Colors.black, size: 50),
      onPressed: () => Navigator.of(context).pushNamed('/meusprodutos'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Usuario? user = Usuario.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return Scaffold(
              body: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 10,
                  ),
                  InkWell(
                      onTap: () {
                        navigateSecondPage(EditImagePage());
                      },
                      child: DisplayImage(
                        imagePath: userProvider.user!.url!,
                        onPressed: () {},
                      )),
                  buildUserInfoDisplay(
                      "${userProvider.user?.nomeUsuario} ${userProvider.user?.sobrenomeUsuario}",
                      'Nome completo',
                      UpdateProfilePage(user)),
                  buildUserInfoDisplay(userProvider.user?.telefoneUsuario,
                      'Telefone', UpdateTelefonePage(user)),
                  buildUserInfoDisplay(userProvider.user?.emailUsuario, 'Email',
                      UpdateEmailPage(user)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildUserInfoDisplay(
          String? getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue!,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                  ]))
            ],
          ));

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
