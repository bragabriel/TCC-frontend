import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/alimento_page/alimento_view.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/alimento_repository.dart';

class AlimentoEditarView extends StatefulWidget {
  final dynamic alimento;

  const AlimentoEditarView(this.alimento, {super.key});

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
  File? imagem;
  String _selectedTipo = 'OUTRO';
  String _selectedUnidade = 'OUTRO';

  // ignore: unused_field
  Usuario? _usuario;

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
    _marcaController.text =
        widget.alimento['alimento']['marcaAlimento'].toString();
    _ofertaController.text =
        widget.alimento['alimento']['ofertaAlimento'].toString();
    _tituloController.text = widget.alimento['tituloArtefato'];
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update alimento");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar alimento'),
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
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 16),
          TextFormField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _marcaController,
            decoration: const InputDecoration(labelText: 'Marca'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _saborController,
            decoration: const InputDecoration(labelText: 'Sabor'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _precoController,
            decoration: const InputDecoration(labelText: 'Preço'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _ofertaController,
            decoration: const InputDecoration(labelText: 'Oferta'),
          ),
          const SizedBox(height: 16),
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
            decoration: const InputDecoration(
              labelText: 'Unidade',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
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
            decoration: const InputDecoration(
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
                ImageHelper.updateImagem(widget.alimento['idArtefato'], imagem);
                await _alimentoRepository.updateAlimento(
                    body, widget.alimento['idArtefato']);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlimentoPage()),
              );
            },
            child: const Text('Atualizar'),
          )
        ]),
      ),
    );
  }
}
