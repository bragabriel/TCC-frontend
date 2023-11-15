import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/helpers/message_helper.dart';
import 'package:spotted/app/view/emprego_page/emprego_view.dart';
import '../../../service/user_provider.dart';
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
  File? imagem;
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
          : "Sem benefícios",
      "cidadeEmprego": _cidadeController.text.isNotEmpty
          ? _cidadeController.text
          : "Não informado",
      "contatoEmprego": _contatoController.text.isNotEmpty
          ? _contatoController.text
          : "Não informado",
      "empresaEmprego": _empresaController.text.isNotEmpty
          ? _empresaController.text
          : "Não informado",
      "estadoEmprego": _estadoController.text.isNotEmpty
          ? _estadoController.text
          : "Não informado",
      "experienciaEmprego": _experienciaController.text.isNotEmpty
          ? _experienciaController.text
          : "Não informado",
      "linkVagaEmprego": _linkVagaController.text.isNotEmpty
          ? _linkVagaController.text
          : "Não informado",
      "localizacaoEmprego": _localizacaoController.text.isNotEmpty
          ? _localizacaoController.text
          : "Não informado",
      "presencialEmprego": _presencialController.text.isNotEmpty
          ? _presencialController.text
          : "Não informado",
      "requisitosEmprego": _requisitosController.text.isNotEmpty
          ? _requisitosController.text
          : "Não informado",
      "tipovagaEmprego": _tipoVagaController.text.isNotEmpty
          ? _tipoVagaController.text
          : "Não informado",
      "salarioEmprego": _salarioController.text.isNotEmpty
          ? double.parse(_salarioController.text)
          : 0,
    };

    try {
      response = await EmpregoRepository().cadastrarEmprego(body);
      print('Cadastro realizado com sucesso em EmpregoCadastrar');
      showSuccessMessage(context);
    } catch (e) {
      print('Erro ao cadastrar em EmpregoCadastraer: $e');
      showErrorMessage(context);
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
        title: const Text('Cadastrar emprego'),
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
    return ListView(padding: const EdgeInsets.all(16), children: <Widget>[
      Column(
        children: [
          TextField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _beneficiosController,
            decoration: const InputDecoration(labelText: 'Benefícios'),
          ),
          TextField(
            controller: _cidadeController,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
          TextField(
            controller: _contatoController,
            decoration: const InputDecoration(labelText: 'Contato'),
          ),
          TextField(
            controller: _empresaController,
            decoration: const InputDecoration(labelText: 'Empresa'),
          ),
          TextField(
            controller: _estadoController,
            decoration: const InputDecoration(labelText: 'Estado'),
          ),
          TextField(
            controller: _experienciaController,
            decoration: const InputDecoration(labelText: 'Experiencia'),
          ),
          TextField(
            controller: _linkVagaController,
            decoration: const InputDecoration(labelText: 'Link da vaga'),
          ),
          TextField(
            controller: _cidadeController,
            decoration: const InputDecoration(labelText: 'Localização'),
          ),
          TextField(
            controller: _presencialController,
            decoration: const InputDecoration(labelText: 'Presencial'),
          ),
          TextField(
            controller: _requisitosController,
            decoration: const InputDecoration(labelText: 'Requisitos'),
          ),
          TextField(
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
          const SizedBox(height: 16),
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
                      content: const Text("Deseja cadastrar o emprego?"),
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
                            await _buscarEmpregos();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EmpregoPage(),
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
    ]);
  }
}
