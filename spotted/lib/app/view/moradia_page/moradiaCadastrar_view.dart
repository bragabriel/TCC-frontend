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
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
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

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato":
            _descricaoController.text.isNotEmpty ? _descricaoController.text : null,
        "idUsuario": 1, //PEGAR ID DO USUARIO
        "tipoArtefato": "Moradia",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "localizacaoMoradia": _localizacaoController.text.isNotEmpty
          ? _localizacaoController.text
          : null,
      "qtdMoradoresPermitidoMoradia":
          _qtdMoradoresPermitidoController.text.isNotEmpty
              ? num.parse(_qtdMoradoresPermitidoController.text)
              : null,
      "qtdMoradoresAtuaisMoradia": _qtdMoradoresAtuaisController.text.isNotEmpty
          ? num.parse(_qtdMoradoresAtuaisController.text)
          : null,
      "precoAluguelTotalMoradia": _precoAluguelTotalController.text.isNotEmpty
          ? num.parse(_precoAluguelTotalController.text)
          : null,
      "precoAluguelPorPessoaMoradia":
          _precoAluguelPorPessoaController.text.isNotEmpty
              ? num.parse(_precoAluguelPorPessoaController.text)
              : null,
      "vagaGaragemMoradia":
          _vagaGaragemController.text.isNotEmpty ? _vagaGaragemController.text : null,
      "animaisEstimacaoMoradia": _animaisEstimacaoController.text.isNotEmpty
          ? _animaisEstimacaoController.text
          : null,
    };

    try {
      await MoradiaRepository().cadastrarMoradia(Moradia.fromJson(body) as Map<String, dynamic>);
      print('Cadastro realizado com sucesso');
    } catch (e) {
      print('Erro ao cadastrar: $e');
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
            controller: _tipoController,
            decoration: InputDecoration(labelText: 'Tipo'),
          ),
          TextField(
            controller: _localizacaoController,
            decoration: InputDecoration(labelText: 'Localização'),
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
