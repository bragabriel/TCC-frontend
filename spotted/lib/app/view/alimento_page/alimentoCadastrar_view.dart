import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class alimentoCadastrarPage extends StatefulWidget {
  @override
  _alimentoCadastrarPageState createState() => _alimentoCadastrarPageState();
}

class _alimentoCadastrarPageState extends State<alimentoCadastrarPage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _saborController = TextEditingController();
  final TextEditingController _unidadeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _ofertaController = TextEditingController();

  Future<void> _cadastrar() async {
  final url = Uri.parse('https://249e-45-172-242-15.ngrok-free.app/api/alimento');
  final body = {
    "artefato": {
      "descricaoArtefato": _descricaoController.text.isNotEmpty ? _descricaoController.text : null,
      "idUsuario": 1,
      "tipoArtefato": "ALIMENTO",
      "tituloArtefato": _tituloController.text.isNotEmpty ? _tituloController.text : null,
    },
    "marcaAlimento": _marcaController.text.isNotEmpty ? _marcaController.text : null,
    "ofertaAlimento": _ofertaController.text.isNotEmpty ? _ofertaController.text : null,
    "precoAlimento": _precoController.text.isNotEmpty ? double.parse(_precoController.text) : null,
    "saborAlimento": _saborController.text.isNotEmpty ? _saborController.text : null,
    "tipoAlimento": _tipoController.text.isNotEmpty ? _tipoController.text : null,
    "unidadeAlimento": _unidadeController.text.isNotEmpty ? _unidadeController.text : null,
  };

  final response = await http.post(
    url,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 201) {
    // Cadastro realizado com sucesso
    // Você pode adicionar um feedback visual ou realizar outras ações aqui
    print('Cadastro realizado com sucesso');
  } else {
    // Erro ao cadastrar
    // Você pode tratar o erro ou fornecer um feedback visual adequado
    print('Erro ao cadastrar: ${response.statusCode}');
    print('Mensagem de erro da API: ${response.body}');
  }
}

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _tipoController.dispose();
    _marcaController.dispose();
    _saborController.dispose();
    _unidadeController.dispose();
    _precoController.dispose();
    _ofertaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar alimento'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _tipoController,
              decoration: InputDecoration(labelText: 'Tipo'),
            ),
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            TextField(
              controller: _saborController,
              decoration: InputDecoration(labelText: 'Sabor'),
            ),
            TextField(
              controller: _unidadeController,
              decoration: InputDecoration(labelText: 'Unidade'),
            ),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _ofertaController,
              decoration: InputDecoration(labelText: 'Oferta'),
            ),
            ElevatedButton(
              onPressed: _cadastrar,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}