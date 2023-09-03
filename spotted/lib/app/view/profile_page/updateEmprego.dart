import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/alimento_repository.dart';

class EmpregoEditarView extends StatefulWidget {
  final dynamic alimento;

  EmpregoEditarView(this.alimento);

  @override
  AlimentoEditarPageState createState() => AlimentoEditarPageState();
}

class AlimentoEditarPageState extends State<EmpregoEditarView> {
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

  //   @override
  // void initState() {
  //   super.initState();
  //   // Preencha os controladores de texto com os valores existentes do alimento
  //   _tituloController.text = widget.alimento.tituloArtefato;
  //   _descricaoController.text = widget.alimento.descricaoArtefato;
  //   _marcaController.text = widget.alimento.marcaAlimento!;
  //   _saborController.text = widget.alimento.saborAlimento!;
  //   _precoController.text = widget.alimento.precoAlimento as String;
  //   _ofertaController.text = widget.alimento.ofertaAlimento!;
  //   _selectedUnidade = widget.alimento.unidadeAlimento!;
  //   _selectedTipo = widget.alimento.tituloArtefato;
  // }

  @override
  void initState() {
    super.initState();
    // Preencha os controladores de texto com os valores existentes do alimento

    // print("eai caralho");
    // print(widget.alimento['tituloArtefato']);
    // print(widget.alimento['tipoAlimento']);
    // print(widget.alimento['unidadeAlimento']);
    // print(widget.alimento['ofertaAlimento']);
    // print(widget.alimento['precoAlimento'].toString());
    // print(widget.alimento['saborAlimento']);
    // print(widget.alimento['marcaAlimento']);
    // print(widget.alimento['descricaoArtefato']);

    // _tituloController.text = widget.alimento['tituloArtefato'];
    // _descricaoController.text = widget.alimento['descricaoArtefato'];
    // _marcaController.text = widget.alimento['marcaAlimento'];
    // _saborController.text = widget.alimento['saborAlimento'];
    // _precoController.text = widget.alimento['precoAlimento'].toString();
    // _ofertaController.text = widget.alimento['ofertaAlimento'];
    // _selectedUnidade = widget.alimento['unidadeAlimento'];
    // _selectedTipo = widget.alimento['tipoAlimento'];
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update emprego");
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar alimento'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _atualizaAlimento();
        },
      ),
    );
  }

  Widget _atualizaAlimento() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
        ElevatedButton(
          onPressed: () async {
            var unidade = _unidadeController.text;
            var descricaoArtefato = _descricaoController.text;
            var tituloArtefato = _tituloController.text;
            var marca = _marcaController.text;
            var oferta = _ofertaController.text;
            var preco = _precoController.text;
            var sabor = _saborController.text;
            var tipo = _tipoController.text;

            try {
              await _alimentoRepository.updateAlimento(
                  _usuario?.idUsuario,
                  unidade,
                  descricaoArtefato,
                  tituloArtefato,
                  marca,
                  oferta,
                  preco,
                  sabor,
                  tipo);

              _showSuccessMessage(context);
            } catch (e) {
              print(e);
            }

            Navigator.pop(context);
          },
          child: Text('Atualizar'),
        )
      ]),
    );
  }
}