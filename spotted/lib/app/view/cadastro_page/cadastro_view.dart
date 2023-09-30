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
          Text(
            'Ops, algo de errado aconteceu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.startCadastro();
            },
            child: Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
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
            Container(
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
                          child: Text('Inserir imagem'),
                        ),
                      ),
                      _buildTextFormField('Usuário', (text) => user = text),
                      SizedBox(height: 8),
                      _buildTextFormField('Email', (text) => email = text),
                      SizedBox(height: 8),
                      _buildTextFormField('Senha', (text) => password = text),
                      SizedBox(height: 8),
                      _buildTextFormField(
                          'Confirme a senha', (text) => confirmPassword = text),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                      _buildTextFormField('Nome', (text) => nome = text),
                      SizedBox(height: 8),
                      _buildTextFormField(
                          'Sobrenome', (text) => sobrenome = text),
                      SizedBox(height: 8),
                      _buildTextFormField(
                          'Telefone', (text) => telefone = text),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Confirmação de cadastro"),
                        content: Text("Deseja cadastrar?"),
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
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text("Sim"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar"),
                          ),
                        ],
                      );
                    });
              },
              child: Text('Cadastrar'),
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Text(
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
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
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
        title: Text('Cadastro'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined),
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
              print('uaghy');
              print(controller.state.value);
              return stateManagement(controller.state.value);
            },
          )
        ],
      ),
    );
  }
}
