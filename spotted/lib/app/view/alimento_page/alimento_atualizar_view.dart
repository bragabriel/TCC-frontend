import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/alimento_model.dart';
import '../../model/usuario_model.dart';
import '../../repository/alimento_repository.dart';

class AlimentoEditarView extends StatefulWidget {
  final dynamic alimento;

  AlimentoEditarView(this.alimento);

  @override
  AlimentoEditarPageState createState() => AlimentoEditarPageState();
}

class AlimentoEditarPageState extends State<AlimentoEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _saborController = TextEditingController();
  final TextEditingController _unidadeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _ofertaController = TextEditingController();
  final AlimentoRepository _alimentoRepository = AlimentoRepository();
  Response<dynamic>? response;
  late File? imagem;
  String _selectedTipo = 'OUTRO';
  String _selectedUnidade = 'OUTRO';
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
    _tipoController.dispose();
    _marcaController.dispose();
    _saborController.dispose();
    _unidadeController.dispose();
    _precoController.dispose();
    _ofertaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _descricaoController.text = widget.alimento['descricaoArtefato'];
    _marcaController.text =
        widget.alimento['alimento']['marcaAlimento'].toString();
    _ofertaController.text =
        widget.alimento['alimento']['ofertaAlimento'].toString();
    _saborController.text =
        widget.alimento['alimento']['saborAlimento'].toString();
    _precoController.text =
        widget.alimento['alimento']['precoAlimento'].toString();
    _tituloController.text = widget.alimento['tituloArtefato'];
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update alimento");
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar alimento'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          print(widget.alimento['idArtefato']);
          return _atualizaAlimento();
        },
      ),
    );
  }

  Widget _atualizaAlimento() {
    final body = {
      "descricaoArtefato": _descricaoController.text,
      "tituloArtefato": _tituloController.text,
      "marcaAlimento": _marcaController.text,
      "ofertaAlimento": _ofertaController.text,
      "precoAlimento": _precoController.text,
      "saborAlimento": _saborController.text,
      "tipoAlimento": _tipoController.text,
      "unidadeAlimento": _unidadeController.text
    };

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: 16),
          TextFormField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _marcaController,
            decoration: InputDecoration(labelText: 'Marca'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _saborController,
            decoration: InputDecoration(labelText: 'Sabor'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _precoController,
            decoration: InputDecoration(labelText: 'Preço'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 16),
          TextFormField(
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
            items: <String>['DOCE', 'SALGADO', 'OUTRO']
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
                imagem ??= File('assets/images/imagem.png');
                ImageHelper.uploadImagem(response!, imagem);
                await _alimentoRepository.updateAlimento(
                    body, widget.alimento['idArtefato']);
                _showSuccessMessage(context);
                print("deu bom atualizar essa porra");
              } catch (e) {
                print("deu algum erro ao atualizar a porra do alimento");
                print(e);
              }
              await _buscarAlimentos();
              Navigator.pop(context);
            },
            child: Text('Atualizar'),
          )
        ]),
      ),
    );
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
}
