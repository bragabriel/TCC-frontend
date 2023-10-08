import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'alimento_view.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/alimento_repository.dart';

class AlimentoCadastrarView extends StatefulWidget {
  const AlimentoCadastrarView({super.key});

  @override
  AlimentoCadastrarPageState createState() => AlimentoCadastrarPageState();
}

class AlimentoCadastrarPageState extends State<AlimentoCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _saborController = TextEditingController();
  final TextEditingController _unidadeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _ofertaController = TextEditingController();
  Response<dynamic>? response;
  File? imagem;
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
        "tipoArtefato": "ALIMENTO",
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
      print("GetAllAlimentos com sucesso em AlimentoCadastrarView");
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de alimentos em AlimentoCadastrarView: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar alimento'),
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
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _marcaController,
              decoration: const InputDecoration(labelText: 'Marca'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _saborController,
              decoration: const InputDecoration(labelText: 'Sabor'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ofertaController,
              decoration: const InputDecoration(labelText: 'Oferta'),
            ),
            const SizedBox(height: 16),
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
              decoration: const InputDecoration(
                labelText: 'Unidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedTipo,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTipo = newValue ?? '';
                });
              },
              items: <String>['DOCE', 'SALGADO', 'OUTRO']
                  .map<DropdownMenuItem<String>>((String value) {
                _tipoController.text = value;
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Tipo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: ElevatedButton(
                onPressed: () async =>
                    imagem = await ImageHelper.selecionarImagem(),
                child: const Text('Inserir imagem'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirmação de cadastro"),
                      content: const Text("Deseja cadastrar o alimento?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await _cadastrar();

                            // Carregar a imagem dos recursos (assets) para um arquivo temporário
                            final ByteData data = await rootBundle
                                .load('assets/images/imagem.png');
                            final List<int> bytes = data.buffer.asUint8List();
                            final File tempImage = File(
                                '${(await getTemporaryDirectory()).path}/imagem.png');
                            await tempImage.writeAsBytes(bytes);

                            ImageHelper.uploadImagem(response!, tempImage);

                            await _buscarAlimentos();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AlimentoPage(),
                              ),
                            );

                            // Remover o arquivo temporário após o uso
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
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ],
    );
  }
}
