import 'dart:io';
import 'moradia_view.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../helpers/image_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/moradia_repository.dart';
import '../../model/moradia_model.dart';

class MoradiaCadastrarView extends StatefulWidget {
  const MoradiaCadastrarView({Key? key}) : super(key: key);

  @override
  MoradiaCadastrarPageState createState() => MoradiaCadastrarPageState();
}

class MoradiaCadastrarPageState extends State<MoradiaCadastrarView> {
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
  Response<dynamic>? response;
  late File? imagem;
  Usuario? _usuario;

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": _usuario?.idUsuario,
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
      response = await MoradiaRepository()
          .cadastrarMoradia(body);
      print('Cadastro realizado com sucesso em MoradiaCadastrarView');
      print(response);
    } catch (e) {
      print('Erro ao cadastrar em MoradiaCadastrarView: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar moradia'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _cadastrarMoradia();
        },
      ),
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

  Future<void> _buscarMoradia() async {
    try {
      await MoradiaRepository().getAllMoradias();
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de moradias: $e');
    }
  }

  SingleChildScrollView _cadastrarMoradia() {
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
          SizedBox(height: 10),
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
          SizedBox(height: 10),
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
                      content: Text("Deseja cadastrar o alimento?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await _cadastrar();
                            await ImageHelper.uploadImagem(response!, imagem!);
                            await _buscarMoradia();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MoradiaPage()));
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
                  },
                );
              },
              child: Text('Cadastrar'),
            ),
          ),
        ],
      ),
    );
  }
}
