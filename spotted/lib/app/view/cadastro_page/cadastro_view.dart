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

  void _showSuccessMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Cadastro realizado com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showErrorMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Erro ao cadastrar. Por favor, tente novamente!'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Formulário de Cadastro',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
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
                    _buildTextFormField('Telefone', (text) => telefone = text),
                  ],
                ),
              ),
            ),
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
            const SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Verificações de validação
                  if (user.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty ||
                      confirmPassword.isEmpty ||
                      nome.isEmpty ||
                      sobrenome.isEmpty ||
                      telefone.isEmpty) {
                    // Um ou mais campos estão vazios, exiba uma mensagem de erro.
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Erro"),
                          content: const Text(
                              "Por favor, preencha todos os campos."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Ok"),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (password != confirmPassword) {
                    // As senhas não coincidem, exiba uma mensagem de erro.
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Erro"),
                          content: const Text(
                              "As senhas não coincidem. Por favor, verifique."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Ok"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Todos os campos estão preenchidos e as senhas coincidem, continue com o processo de cadastro.
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
                      },
                    );
                  }
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
      _showSuccessMessage(context);
    } catch (e) {
      print('Erro ao cadastrar: $e');
      _showErrorMessage(context);
    }
    Navigator.of(context).pushReplacementNamed('/');
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
              return stateManagement(controller.state.value);
            },
          )
        ],
      ),
    );
  }
}
