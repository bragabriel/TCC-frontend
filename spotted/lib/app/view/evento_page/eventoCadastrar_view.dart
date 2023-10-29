import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotted/app/helpers/message_helper.dart';
import '../../repository/usuario_repository.dart';
import 'evento_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/evento_repository.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';

class EventoCadastrarView extends StatefulWidget {
  const EventoCadastrarView({super.key});

  @override
  EventoCadastrarPageState createState() => EventoCadastrarPageState();
}

class EventoCadastrarPageState extends State<EventoCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final UsuarioRepository usuarioRepository = UsuarioRepository();

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
        "tipoArtefato": "EVENTO",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "localizacaoFesta": _localizacaoController.text.isNotEmpty
          ? _localizacaoController.text
          : "Localização não informada",
    };

    try {
      await EventoRepository().cadastrarEvento(body);
    } catch (e) {
      print('Erro ao cadastrar em EventoCadastrarView: $e');
    }
  }

  Future<void> _buscarEventos() async {
    try {
      await EventoRepository().getAllEventos();
      print("GetAllEventos concluído com sucesso em EventoCadastrarView");
      showSuccessMessage(context);
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de eventos em eventoCadastrarView: $e');
      showErrorMessage(context);
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _localizacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar evento'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _cadastroevento();
        },
      ),
    );
  }

  SingleChildScrollView _cadastroevento() {
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
            controller: _localizacaoController,
            decoration: const InputDecoration(labelText: 'Localização'),
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
                      content: const Text("Deseja cadastrar o evento?"),
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
                            await _buscarEventos();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EventoPage(),
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
