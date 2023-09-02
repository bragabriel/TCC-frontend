import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/profile_page/updatePerfil_view.dart';
import '../../../service/change_notifier.dart';
import '../../controller/usuario_controller.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), // Defina a cor da borda desejada
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinhe os textos à esquerda horizontalmente
                  children: [
                    _buildText('Nome: ${userProvider.user?.nomeUsuario}'),
                    _buildText('Sobrenome: ${userProvider.user?.sobrenomeUsuario}'),
                    _buildText('Aniversário: ${userProvider.user?.dataNascimento}'),
                    _buildText('Telefone: ${userProvider.user?.telefoneUsuario}'),
                    _buildText('Email: ${userProvider.user?.emailUsuario}'),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UpdateProfilePage(userProvider.user!)),
                          );
                        },
                        child: Text('Alterar Informações'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          ), 
        textAlign: TextAlign.left, 
      ),
    );
  }
}
