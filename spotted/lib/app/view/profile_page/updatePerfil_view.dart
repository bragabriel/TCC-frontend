import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/model/usuario_model.dart';

import '../../controller/usuario_controller.dart';

class UpdateProfilePage extends StatelessWidget {
    
  final Usuario user;

  UpdateProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: user.nomeUsuario,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              initialValue: user.telefoneUsuario,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextFormField(
              initialValue: user.emailUsuario,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para atualizar as informações do usuário aqui
              },
              child: Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}