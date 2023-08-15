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
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _requisitosController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _experienciaController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final TextEditingController _presencialController = TextEditingController();
  final TextEditingController _tipoVagaController = TextEditingController();

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": 1, // PEGAR ID DO USUARIO

        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "beneficiosEmprego": _beneficiosController.text.isNotEmpty
          ? _beneficiosController.text
          : null,
      "cidadeEmprego":
          _cidadeController.text.isNotEmpty ? _cidadeController.text : null,
      "contatoEmprego":
          _contatoController.text.isNotEmpty ? _contatoController.text : null,
      "empresaEmprego":
          _empresaController.text.isNotEmpty ? _empresaController.text : null,
      "estadoEmprego":
          _estadoController.text.isNotEmpty ? _estadoController.text : null,
      "experienciaEmprego": _experienciaController.text.isNotEmpty
          ? _experienciaController.text
          : null,
      "linkVagaEmprego":
          _linkVagaController.text.isNotEmpty ? _linkVagaController.text : null,
      "localizacaoEmprego": _localizacaoController.text.isNotEmpty
          ? _localizacaoController.text
          : null,
      "presencialEmprego": _presencialController.text.isNotEmpty
          ? _presencialController.text
          : null,
      "requisitosEmprego": _requisitosController.text.isNotEmpty
          ? _requisitosController.text
          : null,
      "tipovagaEmprego":
          _tipoVagaController.text.isNotEmpty ? _tipoVagaController.text : null,
      "salarioEmprego": _salarioController.text.isNotEmpty
          ? double.parse(_salarioController.text)
          : null,
    };

    try {
      await EmpregoRepository().cadastrarEmprego(body);
      print('Cadastro realizado com sucesso');
      AlertDialog(
        title: Text("Oba!"),
        content: Text("Adicionamos sua vaga a nossa base de dados. Boa sorte!"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"))
        ],
      );
    } catch (e) {
      AlertDialog(
        title: Text("Eita!"),
        content: Text("Tivemos um erro ao cadastrar sua vaga."),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"))
        ],
      );
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
    _cidadeController.dispose();
    _requisitosController.dispose();
    _salarioController.dispose();
    _tipoVagaController.dispose();
    _presencialController.dispose();
    _localizacaoController.dispose();
    _experienciaController.dispose();
    _estadoController.dispose();
    _empresaController.dispose();
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
              controller: _cidadeController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _contatoController,
              decoration: InputDecoration(labelText: 'Contato'),
            ),
            TextField(
              controller: _empresaController,
              decoration: InputDecoration(labelText: 'Empresa'),
            ),
            TextField(
              controller: _estadoController,
              decoration: InputDecoration(labelText: 'Estado'),
            ),
            TextField(
              controller: _experienciaController,
              decoration: InputDecoration(labelText: 'Experiencia'),
            ),
            TextField(
              controller: _linkVagaController,
              decoration: InputDecoration(labelText: 'Link da vaga'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: InputDecoration(labelText: 'Localização'),
            ),
            TextField(
              controller: _presencialController,
              decoration: InputDecoration(labelText: 'Presencial'),
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
            TextField(
              controller: _tipoVagaController,
              decoration: InputDecoration(labelText: 'Modalidade'),
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
