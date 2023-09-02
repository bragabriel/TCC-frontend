import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/transporte_repository.dart';
import 'package:spotted/app/view/transporte_page/transporte_view.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';

class TransporteCadastrarView extends StatefulWidget {
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
      "cidadeTransporte":
          _cidadeTransporte.text.isNotEmpty ? _cidadeTransporte.text : null,
      "informacoesCondutorTransporte":
          _informacoesCondutorTransporteController.text.isNotEmpty
              ? _informacoesCondutorTransporteController.text
              : null,
      "informacoesVeiculoTransporte":
          _informacoesVeiculoTransporteController.text.isNotEmpty
              ? _informacoesVeiculoTransporteController.text
              : null,
      "periodoTransporte":
          _periodoTransporte.text.isNotEmpty ? _periodoTransporte.text : null,
      "qtdAssentosPreenchidosTransporte":
          _qtdAssentosPreenchidosTransporteController.text.isNotEmpty
              ? int.parse(_qtdAssentosPreenchidosTransporteController.text)
              : null,
      "qtdAssentosTotalTransporte":
          _qtdAssentosTotalTransporteController.text.isNotEmpty
              ? int.parse(_qtdAssentosTotalTransporteController.text)
              : null,
      "valorTransporte": _valorTransporteController.text.isNotEmpty
          ? double.parse(_valorTransporteController.text)
          : null,
    };

    try {
      response = await TransporteRepository().cadastrarTransporte(body);
      print('Cadastro realizado com sucesso em TransporteCadastrarView');


    } catch (e) {
      print('Erro ao cadastrar em TransporteCadastrarView: $e');
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
      setState(() {
});
    } catch (e) {
      print('Erro ao obter a lista de Transportes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar trasnporte'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _cadastrarTransporte();
        },
      ),
    );
  }

  Widget _cadastrarTransporte(){
    return  SingleChildScrollView(
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
              controller: _cidadeTransporte,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _periodoTransporte,
              decoration: InputDecoration(labelText: 'Turno'),
            ),
            TextField(
              controller: _informacoesVeiculoTransporteController,
              decoration: InputDecoration(labelText: 'Informações do veículo'),
            ),
            TextField(
              controller: _informacoesCondutorTransporteController,
              decoration: InputDecoration(labelText: 'Informações do condutor'),
            ),
            TextField(
              controller: _qtdAssentosPreenchidosTransporteController,
              decoration: InputDecoration(labelText: 'Assentos ocupados'),
            ),
            TextField(
              controller: _qtdAssentosTotalTransporteController,
              decoration: InputDecoration(labelText: 'Capacidade maxíma'),
            ),
            TextField(
              controller: _valorTransporteController,
              decoration: InputDecoration(labelText: 'Valor'),
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
                        content: Text("Deseja cadastrar o emprego?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await _cadastrar();
                              await ImageHelper.uploadImagem(response!, imagem);
                              await _buscarTransportes();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransportePage()));
                            },
                            child: Text('Sim'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar"),
                          ),
                        ],
                      );
                    });
              },
              child: Text('Cadastrar'),
            ),
          ),
          ],
        ),
      );
  }
}