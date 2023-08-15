import 'package:flutter/material.dart';
import '../../repository/moradia_repository.dart';
import '../../model/moradia_model.dart';

class MoradiaCadastrarView extends StatefulWidget {
  const MoradiaCadastrarView({Key? key}) : super(key: key);

  @override
  _MoradiaCadastrarPageState createState() => _MoradiaCadastrarPageState();
}

class _MoradiaCadastrarPageState extends State<MoradiaCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _bairroMoradiaController =
      TextEditingController();
  final TextEditingController _cepMoradiaController = TextEditingController();
  final TextEditingController _cidadeMoradiaController =
      TextEditingController();
  final TextEditingController _estadoMoradiaController =
      TextEditingController();
  final TextEditingController _qtdMoradoresPermitidoController =
      TextEditingController();
  final TextEditingController _qtdMoradoresAtuaisController =
      TextEditingController();
  final TextEditingController _precoAluguelTotalController =
      TextEditingController();
  final TextEditingController _precoAluguelPorPessoaController =
      TextEditingController();
  final TextEditingController _vagaGaragemController = TextEditingController();
  final TextEditingController _animaisEstimacaoController =
      TextEditingController();
  final TextEditingController _contatoController = TextEditingController();

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": 1, //PEGAR ID DO USUARIO

        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "bairroMoradia": _bairroMoradiaController.text.isNotEmpty
          ? _bairroMoradiaController.text
          : null,
      "cepMoradia": _cepMoradiaController.text.isNotEmpty
          ? _cepMoradiaController.text
          : null,
      "cidadeMoradia": _cidadeMoradiaController.text.isNotEmpty
          ? _cidadeMoradiaController.text
          : null,
      "estadoMoradia": _estadoMoradiaController.text.isNotEmpty
          ? _estadoMoradiaController.text
          : null,
      "precoAluguelPorPessoaMoradia":
          _precoAluguelPorPessoaController.text.isNotEmpty
              ? num.parse(_precoAluguelPorPessoaController.text)
              : null,
      "precoAluguelTotalMoradia": _precoAluguelTotalController.text.isNotEmpty
          ? num.parse(_precoAluguelTotalController.text)
          : null,
      "qtdMoradoresAtuaisMoradia": _qtdMoradoresAtuaisController.text.isNotEmpty
          ? num.parse(_qtdMoradoresAtuaisController.text)
          : null,
      "qtdMoradoresPermitidoMoradia":
          _qtdMoradoresPermitidoController.text.isNotEmpty
              ? num.parse(_qtdMoradoresPermitidoController.text)
              : null,
      "vagaGaragemMoradia": _vagaGaragemController.text.isNotEmpty
          ? _vagaGaragemController.text
          : null,
      "animaisEstimacaoMoradia": _animaisEstimacaoController.text.isNotEmpty
          ? _animaisEstimacaoController.text
          : null,
      "contatoMoradia":
          _contatoController.text.isNotEmpty ? _contatoController.text : null,
    };

    try {
      await MoradiaRepository()
          .cadastrarMoradia(Moradia.fromJson(body) as Map<String, dynamic>);
      print('Cadastro realizado com sucesso');
      AlertDialog(
        title: Text("Oba!"),
        content:
            Text("Adicionamos sua moradia a nossa base de dados. Boa sorte!"),
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
        content: Text("Tivemos um erro ao cadastrar sua moradia."),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar moradia'),
      ),
      body: _cadastroMoradia(),
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _animaisEstimacaoController.dispose();
    _vagaGaragemController.dispose();
    _precoAluguelPorPessoaController.dispose();
    _precoAluguelTotalController.dispose();
    _qtdMoradoresAtuaisController.dispose();
    _qtdMoradoresPermitidoController.dispose();
    _estadoMoradiaController.dispose();
    _cidadeMoradiaController.dispose();
    _cepMoradiaController.dispose();
    _bairroMoradiaController.dispose();
    _contatoController.dispose();
    super.dispose();
  }

  SingleChildScrollView _cadastroMoradia() {
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
            controller: _estadoMoradiaController,
            decoration: InputDecoration(labelText: 'Estado'),
          ),
          TextField(
            controller: _cidadeMoradiaController,
            decoration: InputDecoration(labelText: 'Cidade'),
          ),
          TextField(
            controller: _bairroMoradiaController,
            decoration: InputDecoration(labelText: 'Bairro'),
          ),
          TextField(
            controller: _cepMoradiaController,
            decoration: InputDecoration(labelText: 'CEP'),
          ),
          TextField(
            controller: _qtdMoradoresPermitidoController,
            decoration: InputDecoration(labelText: 'Qtd Moradores Permitido'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _qtdMoradoresAtuaisController,
            decoration: InputDecoration(labelText: 'Qtd Moradores Atuais'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _precoAluguelTotalController,
            decoration: InputDecoration(labelText: 'Preço Aluguel Total'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _precoAluguelPorPessoaController,
            decoration: InputDecoration(labelText: 'Preço Aluguel por Pessoa'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _vagaGaragemController,
            decoration: InputDecoration(labelText: 'Vaga Garagem'),
          ),
          TextField(
            controller: _animaisEstimacaoController,
            decoration: InputDecoration(labelText: 'Animais Estimação'),
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
