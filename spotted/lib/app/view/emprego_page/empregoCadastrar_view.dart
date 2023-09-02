import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/emprego_page/emprego_view.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/emprego_repository.dart';

class EmpregoCadastrarView extends StatefulWidget {
  const EmpregoCadastrarView({super.key});

  @override
  EmpregoCadastrarViewState createState() => EmpregoCadastrarViewState();
}

class EmpregoCadastrarViewState extends State<EmpregoCadastrarView> {
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
  Response<dynamic>? response;
  late File? imagem;
  Usuario? _usuario;
  String _selectedModalidade = 'HIBRIDO';

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": _usuario?.idUsuario,
        "tipoArtefato": "EMPREGO",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "beneficiosEmprego": _beneficiosController.text.isNotEmpty
          ? _beneficiosController.text
          : null,
      "cidadeEmprego":
          _cidadeController.text.isNotEmpty ? _cidadeController.text : null,
      "contatoEmprego":
          _contatoController.text.isNotEmpty ? _contatoController.text : null,
      "empresaEmprego":
          _empresaController.text.isNotEmpty ? _empresaController.text : null,
      "estadoEmprego":
          _estadoController.text.isNotEmpty ? _estadoController.text : null,
      "experienciaEmprego": _experienciaController.text.isNotEmpty
          ? _experienciaController.text
          : null,
      "linkVagaEmprego":
          _linkVagaController.text.isNotEmpty ? _linkVagaController.text : null,
      "localizacaoEmprego": _localizacaoController.text.isNotEmpty
          ? _localizacaoController.text
          : null,
      "presencialEmprego": _presencialController.text.isNotEmpty
          ? _presencialController.text
          : null,
      "requisitosEmprego": _requisitosController.text.isNotEmpty
          ? _requisitosController.text
          : null,
      "tipovagaEmprego":
          _tipoVagaController.text.isNotEmpty ? _tipoVagaController.text : null,
      "salarioEmprego": _salarioController.text.isNotEmpty
          ? double.parse(_salarioController.text)
          : null,
    };

    try {
      response = await EmpregoRepository().cadastrarEmprego(body);
      print('Cadastro realizado com sucesso em EmpregoCadastrar');
    } catch (e) {
      print('Erro ao cadastrar em EmpregoCadastraer: $e');
    }
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

  Future<void> _buscarEmpregos() async {
    try {
      await EmpregoRepository().getAllEmpregos();
      print("GetAllEmpregos com suceso em EmpregoCadastrarView");
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de empregos em EmpregoCadastrarView: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar emprego'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _cadastrarEmprego();
        },
      ),
    );
  }

  Widget _cadastrarEmprego() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _beneficiosController,
            decoration: InputDecoration(labelText: 'Benefícios'),
          ),
          TextField(
            controller: _cidadeController,
            decoration: InputDecoration(labelText: 'Cidade'),
          ),
          TextField(
            controller: _contatoController,
            decoration: InputDecoration(labelText: 'Contato'),
          ),
          TextField(
            controller: _empresaController,
            decoration: InputDecoration(labelText: 'Empresa'),
          ),
          TextField(
            controller: _estadoController,
            decoration: InputDecoration(labelText: 'Estado'),
          ),
          TextField(
            controller: _experienciaController,
            decoration: InputDecoration(labelText: 'Experiencia'),
          ),
          TextField(
            controller: _linkVagaController,
            decoration: InputDecoration(labelText: 'Link da vaga'),
          ),
          TextField(
            controller: _cidadeController,
            decoration: InputDecoration(labelText: 'Localização'),
          ),
          TextField(
            controller: _presencialController,
            decoration: InputDecoration(labelText: 'Presencial'),
          ),
          TextField(
            controller: _requisitosController,
            decoration: InputDecoration(labelText: 'Requisitos'),
          ),
          TextField(
            controller: _salarioController,
            decoration: InputDecoration(labelText: 'Salário'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 16),
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
            decoration: InputDecoration(
              labelText: 'Modalidade',
              border: OutlineInputBorder(),
            ),
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
                        content: Text("Deseja cadastrar o emprego?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await _cadastrar();
                              await ImageHelper.uploadImagem(response!, imagem);
                              await _buscarEmpregos();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmpregoPage()));
                            },
                            child: Text('Sim'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar"),
                          ),
                        ],
                      );
                    });
              },
              child: Text('Cadastrar'),
            ),
          ),
        ],
      ),
    );
  }
}
