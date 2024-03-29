import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotted/app/helpers/message_helper.dart';
import 'moradia_view.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../../../service/user_provider.dart';
import '../../helpers/usuario_helper.dart';
import '../../helpers/image_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/moradia_repository.dart';

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
  File? imagem;
  Usuario? _usuario;

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": _usuario?.idUsuario,
        "tipoArtefato": "MORADIA",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "bairroMoradia": _bairroMoradiaController.text.isNotEmpty
          ? _bairroMoradiaController.text
          : "Bairro não cadastrado",
      "cepMoradia": _cepMoradiaController.text.isNotEmpty
          ? _cepMoradiaController.text
          : "CEP não informado",
      "cidadeMoradia": _cidadeMoradiaController.text.isNotEmpty
          ? _cidadeMoradiaController.text
          : "Cidade não cadastrada",
      "estadoMoradia": _estadoMoradiaController.text.isNotEmpty
          ? _estadoMoradiaController.text
          : "Estado não cadastrado",
      "precoAluguelPorPessoaMoradia":
          _precoAluguelPorPessoaController.text.isNotEmpty
              ? num.parse(_precoAluguelPorPessoaController.text)
              : 0,
      "precoAluguelTotalMoradia": _precoAluguelTotalController.text.isNotEmpty
          ? num.parse(_precoAluguelTotalController.text)
          : 0,
      "qtdMoradoresAtuaisMoradia": _qtdMoradoresAtuaisController.text.isNotEmpty
          ? num.parse(_qtdMoradoresAtuaisController.text)
          : 0,
      "qtdMoradoresPermitidoMoradia":
          _qtdMoradoresPermitidoController.text.isNotEmpty
              ? num.parse(_qtdMoradoresPermitidoController.text)
              : 0,
      "vagaGaragemMoradia": _vagaGaragemController.text.isNotEmpty
          ? _vagaGaragemController.text
          : "Não informado",
      "animaisEstimacaoMoradia": _animaisEstimacaoController.text.isNotEmpty
          ? _animaisEstimacaoController.text
          : "Não informado",
      "contatoMoradia": _contatoController.text.isNotEmpty
          ? _contatoController.text
          : "Não informado",
    };

    try {
      response = await MoradiaRepository().cadastrarMoradia(body);
      print('Cadastro realizado com sucesso em MoradiaCadastrarView');
      showSuccessMessage(context);
    } catch (e) {
      print('Erro ao cadastrar em MoradiaCadastrarView: $e');
      showErrorMessage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar moradia'),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Titulo'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _estadoMoradiaController,
            decoration: const InputDecoration(labelText: 'Estado'),
          ),
          TextField(
            controller: _cidadeMoradiaController,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
          TextField(
            controller: _bairroMoradiaController,
            decoration: const InputDecoration(labelText: 'Bairro'),
          ),
          TextField(
            controller: _cepMoradiaController,
            decoration: const InputDecoration(labelText: 'CEP'),
          ),
          TextField(
            controller: _qtdMoradoresPermitidoController,
            decoration:
                const InputDecoration(labelText: 'Qtd Moradores Permitido'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _qtdMoradoresAtuaisController,
            decoration:
                const InputDecoration(labelText: 'Qtd Moradores Atuais'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _precoAluguelTotalController,
            decoration: const InputDecoration(labelText: 'Preço Aluguel Total'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _precoAluguelPorPessoaController,
            decoration:
                const InputDecoration(labelText: 'Preço Aluguel por Pessoa'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _vagaGaragemController,
            decoration: const InputDecoration(labelText: 'Vaga Garagem'),
          ),
          TextField(
            controller: _animaisEstimacaoController,
            decoration: const InputDecoration(labelText: 'Animais Estimação'),
          ),
          const SizedBox(height: 10),
          Container(
            child: ElevatedButton(
              onPressed: () async =>
                  imagem = await ImageHelper.selecionarImagem(),
              child: const SizedBox(
                width: double.infinity,
                height: 48.0,
                child: Center(child: Text('Inserir imagem')),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              if (_descricaoController.text.isEmpty ||
                  _tituloController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Erro"),
                      content:
                          const Text("Por favor, preencha todos os campos."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirmação de cadastro"),
                      content: const Text("Deseja cadastrar a moradia?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await _cadastrar();
                            final ByteData data = await rootBundle
                                .load('assets/images/imagem.png');
                            final List<int> bytes = data.buffer.asUint8List();
                            final File tempImage = File(
                                '${(await getTemporaryDirectory()).path}/imagem.png');
                            await tempImage.writeAsBytes(bytes);
                            ImageHelper.uploadImagem(
                                response!, imagem ?? tempImage);
                            await _buscarMoradia();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MoradiaPage(),
                              ),
                            );
                            await tempImage.delete();
                          },
                          child: const Text("Sim"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancelar"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const SizedBox(
              width: double.infinity,
              height: 48.0,
              child: Center(child: Text('Cadastrar')),
            ),
          ),
        ],
      ),
    );
  }
}
