import 'package:flutter/material.dart';
import '../../repository/objeto_repository.dart';

class ObjetoCadastrarView extends StatefulWidget {
  @override
  _ObjetoCadastrarViewState createState() => _ObjetoCadastrarViewState();
}

class _ObjetoCadastrarViewState extends State<ObjetoCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _localizacaoAchado = TextEditingController();
  final TextEditingController _localizacaoAtual = TextEditingController();

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": 1, // PEGAR ID DO USUARIO
        "tipoArtefato": "ALIMENTO",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "contatoObjeto":
          _contatoController.text.isNotEmpty ? _contatoController.text : null,
      "localizacaoAchadoObjeto":
          _localizacaoAchado.text.isNotEmpty ? _localizacaoAchado.text : null,
      "localizacaoAtualObjeto":
          _localizacaoAtual.text.isNotEmpty ? _localizacaoAtual.text : null,
    };

    try {
      await ObjetoRepository().cadastrarObjeto(body);
      print('Cadastro realizado com sucesso');
      AlertDialog(
        title: Text("Oba!"),
        content: Text("Adicionamos o objeto a nossa base de dados. Boa sorte!"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"))
        ],
      );
    } catch (e) {
      print('Erro ao cadastrar: $e');
      AlertDialog(
        title: Text("Eita!"),
        content: Text("Tivemos um erro ao cadastrar o objeto."),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"))
        ],
      );
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _contatoController.dispose();
    _localizacaoAchado.dispose();
    _localizacaoAtual.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Objeto'),
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
              controller: _contatoController,
              decoration: InputDecoration(labelText: 'Contato'),
            ),
            TextField(
              controller: _localizacaoAchado,
              decoration: InputDecoration(labelText: 'Localização encontrado'),
            ),
            TextField(
              controller: _localizacaoAtual,
              decoration: InputDecoration(labelText: 'Localização atual'),
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
