import 'dart:convert';

import 'package:flutter/material.dart';

import '../../repository/emprego_repository.dart';

class EmpregoCadastrarView extends StatefulWidget {
  @override
  _EmpregoCadastrarViewState createState() => _EmpregoCadastrarViewState();
}

class _EmpregoCadastrarViewState extends State<EmpregoCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _beneficiosController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _linkVagaController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final TextEditingController _requisitosController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": 1, // PEGAR ID DO USUARIO
        "tipoArtefato": "EMPREGO",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "beneficiosEmprego": _beneficiosController.text.isNotEmpty
          ? _beneficiosController.text
          : null,
      "contatoEmprego":
          _contatoController.text.isNotEmpty ? _contatoController.text : null,
      "linkVagaEmprego":
          _linkVagaController.text.isNotEmpty ? _linkVagaController.text : null,
      "localizacaoEmprego": _localizacaoController.text.isNotEmpty
          ? _localizacaoController.text
          : null,
      "requisitosEmprego": _requisitosController.text.isNotEmpty
          ? _requisitosController.text
          : null,
      "salarioEmprego": _salarioController.text.isNotEmpty
          ? double.parse(_salarioController.text)
          : null,
    };

    try {
      await EmpregoRepository().cadastrarEmprego(body);
      print('Cadastro realizado com sucesso');
    } catch (e) {
      print('Erro ao cadastrar: $e');
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _beneficiosController.dispose();
    _contatoController.dispose();
    _linkVagaController.dispose();
    _localizacaoController.dispose();
    _requisitosController.dispose();
    _salarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar emprego'),
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
              controller: _beneficiosController,
              decoration: InputDecoration(labelText: 'Benefícios'),
            ),
            TextField(
              controller: _contatoController,
              decoration: InputDecoration(labelText: 'Contato'),
            ),
            TextField(
              controller: _linkVagaController,
              decoration: InputDecoration(labelText: 'Link da vaga'),
            ),
            TextField(
              controller: _localizacaoController,
              decoration: InputDecoration(labelText: 'Localização'),
            ),
            TextField(
              controller: _requisitosController,
              decoration: InputDecoration(labelText: 'Requisitos'),
            ),
            TextField(
              controller: _salarioController,
              decoration: InputDecoration(labelText: 'Salário'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
