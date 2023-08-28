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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${userProvider.user?.nomeUsuario}'),
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
}
