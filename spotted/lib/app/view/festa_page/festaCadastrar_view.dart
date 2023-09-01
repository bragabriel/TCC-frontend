import 'dart:io';
import 'festa_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/festa_repository.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';

class FestaCadastrarView extends StatefulWidget {
  const FestaCadastrarView({super.key});

  @override
  FestaCadastrarPageState createState() => FestaCadastrarPageState();
}

class FestaCadastrarPageState extends State<FestaCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
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
      "localizacaoFesta": _localizacaoController.text.isNotEmpty
          ? _localizacaoController.text
          : null,
    };

    try {
      response = await FestaRepository().cadastrarFesta(body);
      print('Cadastro realizado com sucesso em FestaCadastrarView');
    } catch (e) {
      print('Erro ao cadastrar em FestaCadastrarView: $e');
    }
  }

  Future<void> _buscarFestas() async {
    try {
      await FestaRepository().getAllFestas();
      print("GetAllFestas concluído com sucesso em FestaCadastrarView");
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de festas em FestaCadastrarView: $e');
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
        title: Text('Cadastrar festa'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _cadastrofesta();
        },
      ),
    );
  }

  SingleChildScrollView _cadastrofesta() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Titulo'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _localizacaoController,
            decoration: InputDecoration(labelText: 'Localização'),
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
                      content: Text("Deseja cadastrar o alimento?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await _cadastrar();
                            await ImageHelper.uploadImagem(response!, imagem!);
                            await _buscarFestas();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FestaPage()));
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
          ),
        ],
      ),
    );
  }
}
