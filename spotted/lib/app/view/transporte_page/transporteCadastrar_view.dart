import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/helpers/message_helper.dart';
import 'package:spotted/app/repository/transporte_repository.dart';
import 'package:spotted/app/view/transporte_page/transporte_view.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';

class TransporteCadastrarView extends StatefulWidget {
  const TransporteCadastrarView({super.key});

  @override
  _TransporteCadastrarViewState createState() =>
      _TransporteCadastrarViewState();
}

class _TransporteCadastrarViewState extends State<TransporteCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _cidadeTransporte = TextEditingController();
  final TextEditingController _periodoTransporte = TextEditingController();
  final TextEditingController _qtdAssentosPreenchidosTransporteController =
      TextEditingController();
  final TextEditingController _qtdAssentosTotalTransporteController =
      TextEditingController();
  final TextEditingController _telefoneUsuarioController =
      TextEditingController();
  final TextEditingController _informacoesVeiculoTransporteController =
      TextEditingController();
  final TextEditingController _informacoesCondutorTransporteController =
      TextEditingController();
  final TextEditingController _valorTransporteController =
      TextEditingController();
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
        "tipoArtefato": "TRANSPORTE",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "cidadeTransporte":
          _cidadeTransporte.text.isNotEmpty ? _cidadeTransporte.text : "Cidade indisponível",
      "informacoesCondutorTransporte":
          _informacoesCondutorTransporteController.text.isNotEmpty
              ? _informacoesCondutorTransporteController.text
              : "Informações não cadastradas",
      "informacoesVeiculoTransporte":
          _informacoesVeiculoTransporteController.text.isNotEmpty
              ? _informacoesVeiculoTransporteController.text
              : "Sem informações do veículo",
      "periodoTransporte":
          _periodoTransporte.text.isNotEmpty ? _periodoTransporte.text : "Não informado",
      "qtdAssentosPreenchidosTransporte":
          _qtdAssentosPreenchidosTransporteController.text.isNotEmpty
              ? int.parse(_qtdAssentosPreenchidosTransporteController.text)
              : "Sem informações cadastradas",
      "qtdAssentosTotalTransporte":
          _qtdAssentosTotalTransporteController.text.isNotEmpty
              ? int.parse(_qtdAssentosTotalTransporteController.text)
              : "Sem informações cadastradas",
      "valorTransporte": _valorTransporteController.text.isNotEmpty
          ? double.parse(_valorTransporteController.text)
          : "Sem valor cadastrado",
    };

    try {
      response = await TransporteRepository().cadastrarTransporte(body);
      print('Cadastro realizado com sucesso em TransporteCadastrarView');
      showSuccessMessage(context);
    } catch (e) {
      print('Erro ao cadastrar em TransporteCadastrarView: $e');
      showErrorMessage(context);
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _telefoneUsuarioController.dispose();
    _informacoesVeiculoTransporteController.dispose();
    _informacoesCondutorTransporteController.dispose();
    _valorTransporteController.dispose();
    super.dispose();
  }

  Future<void> _buscarTransportes() async {
    try {
      await TransporteRepository().getAllTransportes();
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de Transportes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar transporte'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _cadastrarTransporte();
        },
      ),
    );
  }

  Widget _cadastrarTransporte() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _cidadeTransporte,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
          TextField(
            controller: _periodoTransporte,
            decoration: const InputDecoration(labelText: 'Turno'),
          ),
          TextField(
            controller: _informacoesVeiculoTransporteController,
            decoration:
                const InputDecoration(labelText: 'Informações do veículo'),
          ),
          TextField(
            controller: _informacoesCondutorTransporteController,
            decoration:
                const InputDecoration(labelText: 'Informações do condutor'),
          ),
          TextField(
            controller: _qtdAssentosPreenchidosTransporteController,
            decoration: const InputDecoration(labelText: 'Assentos ocupados'),
          ),
          TextField(
            controller: _qtdAssentosTotalTransporteController,
            decoration: const InputDecoration(labelText: 'Capacidade maxíma'),
          ),
          TextField(
            controller: _valorTransporteController,
            decoration: const InputDecoration(labelText: 'Valor'),
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
                      content: const Text("Deseja cadastrar o transporte?"),
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
                            await _buscarTransportes();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TransportePage(),
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
