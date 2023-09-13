import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/objeto_repository.dart';

class ObjetoEditarView extends StatefulWidget {
  final dynamic objeto;

  ObjetoEditarView(this.objeto);

  @override
  ObjetoEditarPageState createState() => ObjetoEditarPageState();
}

class ObjetoEditarPageState extends State<ObjetoEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _localizacaoAchado = TextEditingController();
  final TextEditingController _localizacaoAtual = TextEditingController();
  final ObjetoRepository _objetoRepository = ObjetoRepository();
  Response<dynamic>? response;
  late File? imagem;
  Usuario? _usuario;

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
    _contatoController.dispose();
    _localizacaoAchado.dispose();
    _localizacaoAtual.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _descricaoController.text = widget.objeto['descricaoArtefato'];
    _tituloController.text = widget.objeto['tituloArtefato'];
    // _contatoController.text = widget.objeto['objeto']['contatoObjeto'];
    _localizacaoAchado.text = widget.objeto['objeto']['localizacaoAchadoObjeto'];
    _localizacaoAtual.text = widget.objeto['objeto']['localizacaoAtualObjeto'];
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update Objeto");
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Objeto'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          print(widget.objeto['idArtefato']);
          return _atualizaObjeto();
        },
      ),
    );
  }

  Widget _atualizaObjeto() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          // TextFormField(
          //   controller: _contatoController,
          //   decoration: InputDecoration(labelText: 'Contato'),
          // ),
          TextFormField(
            controller: _localizacaoAchado,
            decoration: InputDecoration(labelText: 'Localização encontrado'),
          ),
          TextFormField(
            controller: _localizacaoAtual,
            decoration: InputDecoration(labelText: 'Localização atual'),
          ),
          ElevatedButton(
            onPressed: () async {
              var descricaoArtefato = _descricaoController.text;
              var tituloArtefato = _tituloController.text;
              // var contato = _contatoController.text;
              var localizacaoAchado = _localizacaoAchado.text;
              var localizacaoAtual = _localizacaoAtual.text;

              try {
                await _objetoRepository.updateObjeto(
                    widget.objeto['idArtefato'],
                    descricaoArtefato,
                    tituloArtefato,
                    // contato,
                    localizacaoAchado,
                    localizacaoAtual);

                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              await _buscarObjetos();
              Navigator.pop(context);
            },
            child: Text('Atualizar'),
          )
        ]),
      ),
    );
  }

  Future<void> _buscarObjetos() async {
    try {
      await ObjetoRepository().getAllObjetos();
      print("GetAllObjetos com sucesso em ObjetoCadastrarView");
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de Objetos em ObjetoCadastrarView: $e');
    }
  }
}
