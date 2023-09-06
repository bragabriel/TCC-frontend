import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/festa_repository.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';

class FestaEditarView extends StatefulWidget {
  final dynamic festa;

  FestaEditarView(this.festa);

  @override
  FestaEditarPageState createState() => FestaEditarPageState();
}

class FestaEditarPageState extends State<FestaEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final FestaRepository _festaRepository = FestaRepository();
  Response<dynamic>? response;
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
    _localizacaoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _descricaoController.text = widget.festa['descricaoArtefato'];
    _tituloController.text = widget.festa['tituloArtefato'];
    // _localizacaoController = widget.festa['festa']['localizacaoFesta'];
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update festa");
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar festa'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          print(widget.festa['idArtefato']);
          return _atualizaFesta();
        },
      ),
    );
  }

  Widget _atualizaFesta() {
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
          ElevatedButton(
            onPressed: () async {
              var localizacao = _localizacaoController.text;
              var descricaoArtefato = _descricaoController.text;
              var tituloArtefato = _tituloController.text;

              try {
                await _festaRepository.updatefesta(widget.festa['idArtefato'],
                    localizacao, descricaoArtefato, tituloArtefato);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              await _buscarfestas();
              Navigator.pop(context);
            },
            child: Text('Atualizar'),
          )
        ]),
      ),
    );
  }

  Future<void> _buscarfestas() async {
    try {
      await _festaRepository.getAllFestas();
      print("GetAllfestas com sucesso em festaCadastrarView");
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de festas em festaCadastrarView: $e');
    }
  }
}
