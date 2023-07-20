import 'package:flutter/material.dart';
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
  String dataNascimento = '';
  String nome = '';
  String sobrenome = '';
  String telefone = '';

  Widget _buildTextFormField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        ),
      ),
    );
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
                      _buildTextFormField('User', (text) => user = text),
                      SizedBox(height: 8),
                      _buildTextFormField('Email', (text) => email = text),
                      SizedBox(height: 8),
                      _buildTextFormField('Password', (text) => password = text),
                      SizedBox(height: 8),
                      _buildTextFormField(
                          'Confirm your Password', (text) => confirmPassword = text),
                      SizedBox(height: 8),
                      _buildTextFormField('Data de Nascimento', (text) => dataNascimento = text),
                      SizedBox(height: 8),
                      _buildTextFormField('Nome', (text) => nome = text),
                      SizedBox(height: 8),
                      _buildTextFormField('Sobrenome', (text) => sobrenome = text),
                      SizedBox(height: 8),
                      _buildTextFormField('Telefone', (text) => telefone = text),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                //CHAMAR API PARA CADASTRAR
                _cadastrarUsuario();
              },
              child: Container(
                width: double.infinity,
                child: Text('Cadastrar', textAlign: TextAlign.center),
              ),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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

  // Método para chamar a API e cadastrar o usuário
  void _cadastrarUsuario() async {
    // Construir o corpo da requisição com os dados do usuário
    final Map<String, dynamic> body = {
      'email': email,
      'senha': password,
      'nome': nome,
      'sobrenome': sobrenome,
      'telefone': telefone,
      'dataNascimento': dataNascimento,
      // Adicione outros campos necessários para o cadastro
    };

    try {
      await UsuarioRepository().cadastrarUsuario(body);
      // Caso a API retorne sucesso, mostrar uma mensagem de sucesso ou redirecionar para outra página.
    } catch (e) {
      // Tratar erros aqui, campos faltantes, blabla
      print('Erro ao cadastrar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          _body(),
        ],
      ),
    );
  }
}
