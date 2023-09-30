import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/evento_repository.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';

class EventoEditarView extends StatefulWidget {
  final dynamic evento;

  EventoEditarView(this.evento);

  @override
  EventoEditarPageState createState() => EventoEditarPageState();
}

class EventoEditarPageState extends State<EventoEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final EventoRepository _eventoRepository = EventoRepository();
  Response<dynamic>? response;
  Usuario? _usuario;
  late File? imagem;


  void _showSuccessMessage(BuildContext context) {
    final snackBar = SnackBar(
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
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _descricaoController.text = widget.evento['descricaoArtefato'];
  //   _tituloController.text = widget.evento['tituloArtefato'];
  //   _localizacaoController.text = widget.evento['evento']['localizacaoFesta'];
  // }

  @override
  Widget build(BuildContext context) {
    print("entrou no update evento");
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar evento'),
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
        padding: EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: 16),
          TextFormField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Titulo'),
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextFormField(
            controller: _localizacaoController,
            decoration: InputDecoration(labelText: 'Localização'),
          ),
                    SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                imagem = await ImageHelper.selecionarImagem();
              },
              child: Text('Atualizar imagem'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
              Response<dynamic>? response = widget.evento['idArtefato'];
                imagem ??= File('assets/images/imagem.png');
                ImageHelper.uploadImagem(response, imagem);
                await _eventoRepository.updateEvento(body,
                    widget.evento['idArtefato']);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              await _buscareventos();
              Navigator.pop(context);
            },
            child: Text('Atualizar'),
          )
        ]),
      ),
    );
  }

  Future<void> _buscareventos() async {
    try {
      await _eventoRepository.getAllEventos();
      print("GetAlleventos com sucesso em eventoCadastrarView");
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de eventos em eventoCadastrarView: $e');
    }
  }
}