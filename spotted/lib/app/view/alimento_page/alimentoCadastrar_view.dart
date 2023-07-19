import 'dart:convert';

import 'package:flutter/material.dart';

import '../../repository/alimento_repository.dart';

class AlimentoCadastrarView extends StatefulWidget {
  @override
  _alimentoCadastrarPageState createState() => _alimentoCadastrarPageState();
}

class _alimentoCadastrarPageState extends State<AlimentoCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _saborController = TextEditingController();
  final TextEditingController _unidadeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _ofertaController = TextEditingController();

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": 1, //PEGAR ID DO USUARIO
        "tipoArtefato": "ALIMENTO",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "marcaAlimento":
          _marcaController.text.isNotEmpty ? _marcaController.text : null,
      "ofertaAlimento":
          _ofertaController.text.isNotEmpty ? _ofertaController.text : null,
      "precoAlimento": _precoController.text.isNotEmpty
          ? double.parse(_precoController.text)
          : null,
      "saborAlimento":
          _saborController.text.isNotEmpty ? _saborController.text : null,
      "tipoAlimento":
          _tipoController.text.isNotEmpty ? _tipoController.text : null,
      "unidadeAlimento":
          _unidadeController.text.isNotEmpty ? _unidadeController.text : null,
    };

    try {
      await AlimentoRepository().cadastrarFood(body);
      print('Cadastro realizado com sucesso');
    } catch (e) {
      print('Erro ao cadastrar: $e');
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

