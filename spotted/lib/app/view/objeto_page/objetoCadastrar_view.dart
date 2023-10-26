import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/helpers/message_helper.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/objeto_repository.dart';
import 'objeto_view.dart';

class ObjetoCadastrarView extends StatefulWidget {
  const ObjetoCadastrarView({super.key});

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
  File? imagem;
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
      showSuccessMessage(context);
    } catch (e) {
      print('Erro ao cadastrar: $e');
      showErrorMessage(context);
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
        title: const Text('Cadastrar Objeto'),
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
            controller: _contatoController,
            decoration: const InputDecoration(labelText: 'Contato'),
          ),
          TextField(
            controller: _localizacaoAchado,
            decoration:
                const InputDecoration(labelText: 'Localização encontrado'),
          ),
          TextField(
            controller: _localizacaoAtual,
            decoration: const InputDecoration(labelText: 'Localização atual'),
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
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Confirmação de cadastro"),
                    content: const Text("Deseja cadastrar o objeto?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await _cadastrar();
                          final ByteData data =
                              await rootBundle.load('assets/images/imagem.png');
                          final List<int> bytes = data.buffer.asUint8List();
                          final File tempImage = File(
                              '${(await getTemporaryDirectory()).path}/imagem.png');
                          await tempImage.writeAsBytes(bytes);
                          ImageHelper.uploadImagem(
                              response!, imagem ?? tempImage);
                          await _buscarObjetos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ObjetoPage(),
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
