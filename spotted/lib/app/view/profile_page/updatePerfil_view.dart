import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'package:spotted/app/repository/usuario_repository.dart';

import '../../../service/change_notifier.dart';

class UpdateProfilePage extends StatefulWidget {
  final Usuario user;

  UpdateProfilePage(this.user);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final UsuarioRepository usuarioRepository = UsuarioRepository();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.user.nomeUsuario;
    sobrenomeController.text = widget.user.sobrenomeUsuario;
    telefoneController.text = widget.user.telefoneUsuario;
    emailController.text = widget.user.emailUsuario;
  }

  void _showSuccessMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Informações atualizadas com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: sobrenomeController,
              decoration: InputDecoration(labelText: 'Sobrenome'),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Usuario updatedUser = Usuario(
                    idUsuario: widget.user.idUsuario,
                    nomeUsuario: nomeController.text,
                    sobrenomeUsuario: sobrenomeController.text,
                    dataNascimento: widget.user.dataNascimento,
                    telefoneUsuario: widget.user.telefoneUsuario,
                    emailUsuario: widget.user.emailUsuario,
                  );

                  try {
                    await usuarioRepository.updateUserName(updatedUser.idUsuario!, updatedUser.nomeUsuario, updatedUser.sobrenomeUsuario);

                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    userProvider.updateUserInfo(updatedUser);

                    _showSuccessMessage(context);
                  } catch (e) {
                    print(e);
                  }

                  Navigator.pop(context);
                },
                child: Text('Atualizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
