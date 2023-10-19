import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/emprego_page/emprego_view.dart';
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
  File? imagem;
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
    _beneficiosController.text = widget.emprego['emprego']['beneficioEmprego'].toString();
    _cidadeController.text = widget.emprego['cidadeEmprego'].toString();
    _contatoController.text = widget.emprego['contatoEmprego'].toString();
    _empresaController.text = widget.emprego['empresaEmprego'].toString();
    _estadoController.text = widget.emprego['estadoEmprego'].toString();
    _experienciaController.text =
        widget.emprego['experienciaEmprego'].toString();
    _linkVagaController.text = widget.emprego['linkEmprego'].toString();
    _localizacaoController.text =
        widget.emprego['localizacaoEmprego'].toString();
    _presencialController.text = widget.emprego['presencialEmprego'].toString();
    _requisitosController.text = widget.emprego['requisitosEmprego'].toString();
    _salarioController.text = widget.emprego['salarioEmprego'].toString();
    _tipoVagaController.text = widget.emprego['tipoVagaEmprego'].toString();
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
                final ByteData data =
                    await rootBundle.load('assets/images/imagem.png');
                final List<int> bytes = data.buffer.asUint8List();
                final File tempImage =
                    File('${(await getTemporaryDirectory()).path}/imagem.png');
                await tempImage.writeAsBytes(bytes);
                ImageHelper.updateImagem(widget.emprego['idArtefato'], imagem);
                await _empregoRepository.updateEmprego(
                    body, widget.emprego['idArtefato']);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmpregoPage()),
              );
            },
            child: const Text('Atualizar'),
          )
        ]),
      ),
    );
  }
}
