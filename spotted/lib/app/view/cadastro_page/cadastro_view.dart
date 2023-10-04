import 'dart:io';
import 'package:dio/dio.dart';
import 'package:spotted/app/view/login_page/login_view.dart';
import '../../helpers/image_helper.dart';
import 'package:flutter/material.dart';
import '../../controller/usuario_controller.dart';
import '../../repository/usuario_repository.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String user = '';
  String nome = '';
  String sobrenome = '';
  String telefone = '';
  File? imagem;
  Response<dynamic>? response;

  final controller = UsuarioController();

  _success() {
    return _body();
  }

  _error() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Ops, algo de errado aconteceu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.startCadastro();
            },
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.startCadastro();
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/logo.png'),
            ),
            Container(
              height: 20,
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            imagem = await ImageHelper.selecionarImagem();
                          },
                          child: const Text('Inserir imagem'),
                        ),
                      ),
                      _buildTextFormField('Usuário', (text) => user = text),
                      const SizedBox(height: 8),
                      _buildTextFormField('Email', (text) => email = text),
                      const SizedBox(height: 8),
                      _buildTextFormField('Senha', (text) => password = text),
                      const SizedBox(height: 8),
                      _buildTextFormField(
                          'Confirme a senha', (text) => confirmPassword = text),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      _buildTextFormField('Nome', (text) => nome = text),
                      const SizedBox(height: 8),
                      _buildTextFormField(
                          'Sobrenome', (text) => sobrenome = text),
                      const SizedBox(height: 8),
                      _buildTextFormField(
                          'Telefone', (text) => telefone = text),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Confirmação de cadastro"),
                        content: const Text("Deseja cadastrar?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await _cadastrarUsuario();
                              imagem ??= File('assets/images/imagem.png');
                              ImageHelper.uploadImagem(response!, imagem);
                              //await _buscarEmpregos();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text("Sim"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancelar"),
                          ),
                        ],
                      );
                    });
              },
              child: const Text('Cadastrar'),
            ),
          ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text(
                'Já tem uma conta? Logar.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        ),
      ),
    );
  }

  Future<void> _cadastrarUsuario() async {
    // Construir o corpo da requisição com os dados do usuário
    final Map<String, dynamic> body = {
      'email': email,
      'senha': password,
      'nome': nome,
      'sobrenome': sobrenome,
      'telefone': telefone,
    };

    try {
      await UsuarioRepository().cadastrarUsuario(body);
    } catch (e) {
      print('Erro ao cadastrar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () {
              controller.startCadastro();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/wallpaper.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          AnimatedBuilder(
            animation: controller.state,
            builder: (context, child) {
              print(controller.state.value);
              return stateManagement(controller.state.value);
            },
          )
        ],
      ),
    );
  }
}
