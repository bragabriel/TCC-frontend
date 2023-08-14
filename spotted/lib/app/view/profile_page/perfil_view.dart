import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'package:spotted/app/view/profile_page/edit_email.dart';
import 'package:spotted/app/view/profile_page/edit_image.dart';
import 'package:spotted/app/view/profile_page/edit_name.dart';
import 'package:spotted/app/view/profile_page/edit_phone.dart';
import 'package:spotted/app/widget/display_image_widget.dart';
import '../../../service/change_notifier.dart';
import '../../controller/usuario_controller.dart';
import 'my_products.dart';

class ProfilePage extends StatelessWidget {
  final controller = UsuarioController();
  @override
  Widget build(BuildContext context) {
    Usuario? user = Usuario.empty();
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Sobre mim',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.lime,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                user = userProvider.user;
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateSecondPage(context, EditImagePage());
                      },
                      child: DisplayImage(
                        imagePath: user?.url ?? 'https://miro.medium.com/v2/resize:fit:1400/1*g09N-jl7JtVjVZGcd-vL2g.jpeg',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: double
                          .infinity, // Informa o tamanho horizontal máximo
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            buildUserInfoDisplay(
                                context,
                                user?.nomeUsuario ?? '',
                                'Nome',
                                EditNameFormPage()),
                            buildUserInfoDisplay(
                                context,
                                user?.telefoneUsuario ?? '',
                                'Telefone',
                                EditPhoneFormPage()),
                            buildUserInfoDisplay(
                                context,
                                user?.emailUsuario ?? '',
                                'Email',
                                EditEmailFormPage()),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
         _newButton(Colors.black, Icons.list, user),],
      ),  
    );
  }

  // Método para construir o display item com as informações do usuário
  Widget buildUserInfoDisplay(
      BuildContext context, String getValue, String title, Widget editPage) {
    return Padding(
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
          SizedBox(height: 1),
          Container(
            width: 350,
            height: 40,
            decoration: BoxDecoration(
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
                  child: TextButton(
                    onPressed: () {
                      navigateSecondPage(context, editPage);
                    },
                    child: Text(
                      getValue,
                      style: TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  FutureOr onGoBack(dynamic value, BuildContext context, Usuario newUser) {
    // Rebuild the widget to show the updated user info
    Provider.of<UserProvider>(context, listen: false).updateUserInfo(newUser);
  }

  void navigateSecondPage(BuildContext context, Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then((newValue) {
      // O valor retornado aqui é o novo objeto Usuario com as informações atualizadas
      onGoBack(newValue, context, newValue);
    });
  }
}

Column _newButton(Color color, IconData icon, Usuario? usuario) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      IconButton(
        icon: Icon(icon, color: color, size: 50),
        onPressed: () => MyProductsPage(usuario!),
      ),
      SizedBox(height: 20),
    ],
  );
}
