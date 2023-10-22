import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/usuario_page/usuarioAtualizar_view.dart';
import '../../../service/user_provider.dart';
import '../../model/usuario_model.dart';
import '../../repository/usuario_repository.dart';

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
            return Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
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
                    _myIconButton, // Use o IconButton aqui
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
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}