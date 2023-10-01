import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/profile_page/updatePerfil.dart';
import '../../../service/change_notifier.dart';
import '../../model/usuario_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    IconButton _newButton(Color color, IconData icon, Usuario? usuario) {
      print("entrou no new button");
      return IconButton(
        icon: Icon(icon, color: color, size: 50),
        onPressed: () => Navigator.of(context).pushNamed('/meusprodutos'),
      );
    }

    Usuario? user = Usuario.empty();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            print('URL da imagem: ${userProvider.user?.url}');
            return Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), // Defina a cor da borda desejada
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinhe os textos à esquerda horizontalmente
                  children: [
                    userProvider.user?.url != null
                        ? Image.network(userProvider.user!.url!)
                        : const SizedBox(), 
                    _buildText('Nome: ${userProvider.user?.nomeUsuario}'),
                    _buildText('Sobrenome: ${userProvider.user?.sobrenomeUsuario}'),
                    _buildText('Telefone: ${userProvider.user?.telefoneUsuario}'),
                    _buildText('Email: ${userProvider.user?.emailUsuario}'),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UpdateProfilePage(userProvider.user!)),
                          );
                        },
                        child: const Text('Alterar Informações'),
                      ),
                    ),
                     _newButton(Colors.black, Icons.list, user),
                  ],
                ),
              ),
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

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          ), 
        textAlign: TextAlign.left, 
      ),
    );
  }
}
