import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/profile_page/updatePerfil_view.dart';
import '../../../service/change_notifier.dart';
import '../../model/usuario_model.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
IconButton _newButton(Color color, IconData icon, Usuario? usuario) {
  print("entrou no new button");
  return IconButton(
    icon: Icon(icon, color: color, size: 50),
    onPressed: () =>Navigator.of(context).pushNamed('/meusprodutos'),
  );
}

    Usuario? user = Usuario.empty();
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${userProvider.user?.nomeUsuario}'),
                Text('Sobrenome: ${userProvider.user?.sobrenomeUsuario}'),
                Text('Aniversário: ${userProvider.user?.dataNascimento}'),
                Text('Telefone: ${userProvider.user?.telefoneUsuario}'),
                Text('Email: ${userProvider.user?.emailUsuario}'),
                //Image.network(userProvider.user?.url),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateProfilePage(userProvider.user!)),
                    );
                  },
                  child: Text('Alterar Informações'),
                ),
              ],
            );
          },
        ),
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

