import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/objeto_repository.dart';
import 'objeto_view.dart';

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
        "tipoArtefato": "OBJETO",
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
      response = await ObjetoRepository().cadastrarObjeto(body);
      print('Cadastro realizado com sucesso em ObjetoCadastrarView');
    } catch (e) {
      print('Erro ao cadastrar: $e');
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

  Future<void> _buscarObjetos() async {
    try {
      await ObjetoRepository().getAllObjetos();
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de objetos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Objeto'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _cadastrarObjeto();
        },
      ),
    );
  }

  Widget _cadastrarObjeto() {
    return SingleChildScrollView(
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
                              await _buscarObjetos();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ObjetoPage()));
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
