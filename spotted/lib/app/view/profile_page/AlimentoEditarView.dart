import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/alimento_repository.dart';
import 'my_products.dart';

class AlimentoEditarView extends StatefulWidget {
  const AlimentoEditarView(produto);

  @override
  AlimentoCadastrarPageState createState() => AlimentoCadastrarPageState();
}

class AlimentoCadastrarPageState extends State<AlimentoEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _saborController = TextEditingController();
  final TextEditingController _unidadeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _ofertaController = TextEditingController();
  Response<dynamic>? response;
  late File? imagem;
  Usuario? _usuario;
  String _selectedTipo = 'OUTRO';
  String _selectedUnidade = 'OUTRO';

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
      "marcaAlimento":
          _marcaController.text.isNotEmpty ? _marcaController.text : null,
      "ofertaAlimento":
          _ofertaController.text.isNotEmpty ? _ofertaController.text : null,
      "precoAlimento": _precoController.text.isNotEmpty
          ? double.parse(_precoController.text)
          : null,
      "saborAlimento":
          _saborController.text.isNotEmpty ? _saborController.text : null,
      "tipoAlimento":
          _tipoController.text.isNotEmpty ? _tipoController.text : null,
      "unidadeAlimento":
          _unidadeController.text.isNotEmpty ? _unidadeController.text : null,
    };

    try {
      response = await AlimentoRepository().cadastrarAlimento(body);
      print('Cadastro realizado com sucesso em AlimentoCadastrar');
    } catch (e) {
      print('Erro ao cadastrar em AlimentoCadastrar: $e');
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _tipoController.dispose();
    _marcaController.dispose();
    _saborController.dispose();
    _unidadeController.dispose();
    _precoController.dispose();
    _ofertaController.dispose();
    super.dispose();
  }

  Future<void> _buscarAlimentos() async {
    try {
      await AlimentoRepository().getAllAlimentos();
      print("GetAllAlimentos com sucesso em AlimentoEditarView");
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de alimentos em AlimentoEditarView: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar alimento'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _cadastroAlimento();
        },
      ),
    );
  }

  Widget _cadastroAlimento() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _saborController,
              decoration: InputDecoration(labelText: 'Sabor'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ofertaController,
              decoration: InputDecoration(labelText: 'Oferta'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedUnidade,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUnidade = newValue ?? '';
                });
              },
              items: <String>['PEDAÇO', 'UNIDADE', 'PACK', 'OUTRO']
                  .map<DropdownMenuItem<String>>((String value) {
                _unidadeController.text = value;
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Unidade',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedTipo,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTipo = newValue ?? '';
                });
              },
              items: <String>[
                'DOCE',
                'SALGADO',
                'OUTRO'
              ] 
                  .map<DropdownMenuItem<String>>((String value) {
                _tipoController.text = value;
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Tipo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: ElevatedButton(
                onPressed: () async =>
                    imagem = await ImageHelper.selecionarImagem(),
                child: Text('Inserir imagem'),
              ),
            ),
            ElevatedButton(
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
                            await _buscarAlimentos();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyProductsPage()));
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
          ],
        ),
      ],
    );
  }
}