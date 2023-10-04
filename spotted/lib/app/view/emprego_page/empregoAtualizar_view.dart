import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/emprego_repository.dart';

class EmpregoEditarView extends StatefulWidget {
  final dynamic emprego;

  const EmpregoEditarView(this.emprego, {super.key});

  @override
  EmpregoEditarPageState createState() => EmpregoEditarPageState();
}

class EmpregoEditarPageState extends State<EmpregoEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _beneficiosController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _linkVagaController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _requisitosController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _experienciaController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final TextEditingController _presencialController = TextEditingController();
  final TextEditingController _tipoVagaController = TextEditingController();
  final EmpregoRepository _empregoRepository = EmpregoRepository();
  Response<dynamic>? response;
  
  // ignore: unused_field
  Usuario? _usuario;
  late File? imagem;
  String _selectedModalidade = 'HIBRIDO';

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
    _beneficiosController.dispose();
    _contatoController.dispose();
    _linkVagaController.dispose();
    _cidadeController.dispose();
    _requisitosController.dispose();
    _salarioController.dispose();
    _tipoVagaController.dispose();
    _presencialController.dispose();
    _localizacaoController.dispose();
    _experienciaController.dispose();
    _estadoController.dispose();
    _empresaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _beneficiosController.text = widget.emprego['emprego']['beneficioEmprego'];
    _cidadeController.text = widget.emprego['emprego']['cidadeEmprego'];
    _contatoController.text = widget.emprego['emprego']['contatoEmprego'];
    _empresaController.text = widget.emprego['emprego']['empresaEmprego'];
    _estadoController.text = widget.emprego['emprego']['estadoEmprego'];
    _experienciaController.text =
        widget.emprego['emprego']['experienciaEmprego'];
    _linkVagaController.text = widget.emprego['emprego']['linkEmprego'];
    _localizacaoController.text =
        widget.emprego['emprego']['localizacaoEmprego'];
    _presencialController.text = widget.emprego['emprego']['presencialEmprego'];
    _requisitosController.text = widget.emprego['emprego']['requisitosEmprego'];
    _salarioController.text = widget.emprego['emprego']['salarioEmprego'];
    _tipoVagaController.text = widget.emprego['emprego']['tipoVagaEmprego'];
    _tituloController.text = widget.emprego['tituloArtefato'];
    _descricaoController.text = widget.emprego['descricaoArtefato'];
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update emprego");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar emprego'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _atualizaEmprego();
        },
      ),
    );
  }

  Widget _atualizaEmprego() {
    final body = {
      "descricaoArtefato": _descricaoController.text,
      "tituloArtefato": _tituloController.text,
      "beneficiosEmprego": _beneficiosController.text,
      "cidadeEmprego": _cidadeController.text,
      "contatoEmprego": _contatoController.text,
      "empresaEmprego": _empresaController.text,
      "estadoEmprego": _estadoController.text,
      "experienciaEmprego": _experienciaController.text,
      "linkVagaEmprego": _linkVagaController.text,
      "localizacaoEmprego": _localizacaoController.text,
      "presencialEmprego": _presencialController.text,
      "requisitosEmprego": _requisitosController.text,
      "tipovagaEmprego": _tipoVagaController.text,
      "salarioEmprego": _salarioController.text,
    };

    print("entrou no atualizar emprego");
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 16),
          TextFormField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextFormField(
            controller: _beneficiosController,
            decoration: const InputDecoration(labelText: 'Benefícios'),
          ),
          TextFormField(
            controller: _cidadeController,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
          TextFormField(
            controller: _contatoController,
            decoration: const InputDecoration(labelText: 'Contato'),
          ),
          TextFormField(
            controller: _empresaController,
            decoration: const InputDecoration(labelText: 'Empresa'),
          ),
          TextFormField(
            controller: _estadoController,
            decoration: const InputDecoration(labelText: 'Estado'),
          ),
          TextFormField(
            controller: _experienciaController,
            decoration: const InputDecoration(labelText: 'Experiencia'),
          ),
          TextFormField(
            controller: _linkVagaController,
            decoration: const InputDecoration(labelText: 'Link da vaga'),
          ),
          TextFormField(
            controller: _cidadeController,
            decoration: const InputDecoration(labelText: 'Localização'),
          ),
          TextFormField(
            controller: _presencialController,
            decoration: const InputDecoration(labelText: 'Presencial'),
          ),
          TextFormField(
            controller: _requisitosController,
            decoration: const InputDecoration(labelText: 'Requisitos'),
          ),
          TextFormField(
            controller: _salarioController,
            decoration: const InputDecoration(labelText: 'Salário'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedModalidade,
            onChanged: (String? newValue) {
              setState(() {
                _selectedModalidade = newValue ?? '';
              });
            },
            items: <String>[
              'PRESENCIAL',
              'HIBRIDO',
              'REMOTO',
            ].map<DropdownMenuItem<String>>((String value) {
              _tipoVagaController.text = value;
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: const InputDecoration(
              labelText: 'Modalidade',
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
              child: const Text('Atualizar imagem'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                imagem ??= File('assets/images/imagem.png');
                ImageHelper.updateImagem(widget.emprego['idArtefato'], imagem);
                await _empregoRepository.updateEmprego(
                    body, widget.emprego['idArtefato']);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              Navigator.pop(context);
            },
            child: const Text('Atualizar'),
          )
        ]),
      ),
    );
  }
}
