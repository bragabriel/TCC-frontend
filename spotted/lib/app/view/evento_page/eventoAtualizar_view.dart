import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/evento_repository.dart';
import 'package:spotted/app/view/evento_page/evento_view.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';

class EventoEditarView extends StatefulWidget {
  final dynamic evento;

  const EventoEditarView(this.evento, {super.key});

  @override
  EventoEditarPageState createState() => EventoEditarPageState();
}

class EventoEditarPageState extends State<EventoEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final EventoRepository _eventoRepository = EventoRepository();
  Response<dynamic>? response;
  Usuario? _usuario;
  File? imagem;

  void _showSuccessMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Informações atualizadas com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _localizacaoController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _descricaoController.text = widget.evento['descricaoArtefato'];
    _tituloController.text = widget.evento['tituloArtefato'];
    _localizacaoController.text = widget.evento['localizacaoEvento'].toString();
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update evento");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar evento'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          print(widget.evento['idArtefato']);
          return _atualizaEvento();
        },
      ),
    );
  }

  Widget _atualizaEvento() {
    final body = {
      "descricaoArtefato": _descricaoController.text,
      "tituloArtefato": _tituloController.text,
      "localizacaoEvento": _localizacaoController.text,
    };

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 16),
          TextFormField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Titulo'),
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextFormField(
            controller: _localizacaoController,
            decoration: const InputDecoration(labelText: 'Localização'),
          ),
          //  TextFormField(
          //   controller: _telefoneController,
          //   decoration: const InputDecoration(labelText: 'Telefone'),
          // ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                imagem = await ImageHelper.selecionarImagem();
              },
              child: const Text('Atualizar imagem'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final ByteData data =
                   await rootBundle.load('assets/images/imagem.png');
                final List<int> bytes = data.buffer.asUint8List();
                final File tempImage =
                    File('${(await getTemporaryDirectory()).path}/imagem.png');
                await tempImage.writeAsBytes(bytes);
                ImageHelper.updateImagem(widget.evento['idArtefato'], imagem);
                await _eventoRepository.updateEvento(
                    body, widget.evento['idArtefato']);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventoPage()),
              );
            },
            child: const Text('Atualizar'),
          )
        ]),
      ),
    );
  }
}
