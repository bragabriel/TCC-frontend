import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'package:spotted/app/repository/usuario_repository.dart';
import '../../../service/user_provider.dart';

class UpdateTelefonePage extends StatefulWidget {
  final Usuario user;

  const UpdateTelefonePage(this.user, {super.key});

  @override
  _UpdateTelefonePageState createState() => _UpdateTelefonePageState();
}

class _UpdateTelefonePageState extends State<UpdateTelefonePage> {
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
    const snackBar = SnackBar(
      content: Text('Informações atualizadas com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nomeController,
              keyboardType: TextInputType
                  .number, // Defina o keyboardType para TextInputType.number
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  Usuario updatedUser = Usuario(
                    idUsuario: widget.user.idUsuario,
                    nomeUsuario: nomeController.text,
                    sobrenomeUsuario: sobrenomeController.text,
                    telefoneUsuario: widget.user.telefoneUsuario,
                    emailUsuario: widget.user.emailUsuario,
                  );

                  try {
                    await usuarioRepository.updateUserName(
                        updatedUser.idUsuario,
                        updatedUser.nomeUsuario,
                        updatedUser.sobrenomeUsuario);

                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    userProvider.updateUserInfo(updatedUser);

                    _showSuccessMessage(context);
                  } catch (e) {
                    print(e);
                  }

                  Navigator.pop(context);
                },
                child: const Text('Atualizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
