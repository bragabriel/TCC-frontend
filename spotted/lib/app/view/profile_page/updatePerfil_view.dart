import 'package:flutter/material.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'package:spotted/app/repository/usuario_repository.dart';

class UpdateProfilePage extends StatefulWidget {
  final Usuario user;

  UpdateProfilePage(this.user);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final UsuarioRepository usuarioRepository = UsuarioRepository();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.user.nomeUsuario;
    telefoneController.text = widget.user.telefoneUsuario;
    emailController.text = widget.user.emailUsuario;
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
              controller: telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Usuario updatedUser = Usuario(
                  idUsuario: widget.user.idUsuario,
                  nomeUsuario: nomeController.text,
                  sobrenomeUsuario: widget.user.sobrenomeUsuario,
                  dataNascimento: widget.user.dataNascimento,
                  telefoneUsuario: telefoneController.text,
                  emailUsuario: emailController.text,
                );

                print(updatedUser.nomeUsuario);
                //bater na api atualizando
                //await usuarioRepository.updateUser(updatedUser);

                Navigator.pop(context);
              },
              child: Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
