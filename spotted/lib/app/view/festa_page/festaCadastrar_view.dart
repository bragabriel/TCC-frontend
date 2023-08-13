import 'package:flutter/material.dart';
import 'package:spotted/app/repository/festa_repository.dart';

class FestaCadastrarView extends StatefulWidget {
  const FestaCadastrarView({super.key});

  @override
  FestaCadastrarPageState createState() => FestaCadastrarPageState();
}

class FestaCadastrarPageState extends State<FestaCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "tipoArtefato": "ALIMENTO",
        "idUsuario": 1, // PEGAR ID DO USUARIO
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "localizacaoFesta": _localizacaoController.text.isNotEmpty
          ? _localizacaoController.text
          : null,
    };

    try {
      await FestaRepository().cadastrarFesta(body);
      print('Cadastro realizado com sucesso');
      AlertDialog(
        title: Text("Oba!"),
        content:
            Text("Adicionamos sua festa a nossa base de dados. Boa festa!"),
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
        content: Text("Tivemos um erro ao cadastrar sua festa."),
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
    _localizacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar festa'),
      ),
      body: _cadastrofesta(),
    );
  }

  SingleChildScrollView _cadastrofesta() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Titulo'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _localizacaoController,
            decoration: InputDecoration(labelText: 'Localização'),
          ),
          ElevatedButton(
            onPressed: _cadastrar,
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
