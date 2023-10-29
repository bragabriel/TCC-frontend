import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/moradia_page/moradia_view.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/moradia_repository.dart';

class MoradiaEditarView extends StatefulWidget {
  final dynamic moradia;

  const MoradiaEditarView(this.moradia, {super.key});

  @override
  MoradiaEditarPageState createState() => MoradiaEditarPageState();
}

class MoradiaEditarPageState extends State<MoradiaEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _bairroMoradiaController =
      TextEditingController();
  final TextEditingController _cepMoradiaController = TextEditingController();
  final TextEditingController _cidadeMoradiaController =
      TextEditingController();
  final TextEditingController _estadoMoradiaController =
      TextEditingController();
  final TextEditingController _qtdMoradoresPermitidoController =
      TextEditingController();
  final TextEditingController _qtdMoradoresAtuaisController =
      TextEditingController();
  final TextEditingController _precoAluguelTotalController =
      TextEditingController();
  final TextEditingController _precoAluguelPorPessoaController =
      TextEditingController();
  final TextEditingController _vagaGaragemController = TextEditingController();
  final TextEditingController _animaisEstimacaoController =
      TextEditingController();

  final MoradiaRepository _moradiaRepository = MoradiaRepository();
  Response<dynamic>? response;
  File? imagem;
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
    _animaisEstimacaoController.dispose();
    _vagaGaragemController.dispose();
    _precoAluguelPorPessoaController.dispose();
    _precoAluguelTotalController.dispose();
    _qtdMoradoresAtuaisController.dispose();
    _qtdMoradoresPermitidoController.dispose();
    _estadoMoradiaController.dispose();
    _cidadeMoradiaController.dispose();
    _cepMoradiaController.dispose();
    _bairroMoradiaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tituloController.text = widget.moradia['tituloArtefato'];
    _descricaoController.text = widget.moradia['descricaoArtefato'];
    _bairroMoradiaController.text = widget.moradia['moradia']['bairroMoradia'];
    _cepMoradiaController.text = widget.moradia['moradia']['cepMoradia'];
    _cidadeMoradiaController.text = widget.moradia['moradia']['cidadeMoradia'];
    _estadoMoradiaController.text = widget.moradia['moradia']['estadoMoradia'];
    _precoAluguelPorPessoaController.text =
        widget.moradia['moradia']['precoAluguelPorPessoaMoradia'].toString();
    _precoAluguelTotalController.text =
        widget.moradia['moradia']['precoAluguelTotalMoradia'].toString();
    _qtdMoradoresAtuaisController.text =
        widget.moradia['moradia']['qtdMoradoresAtuaisMoradia'].toString();
    _vagaGaragemController.text =
        widget.moradia['moradia']['vagaGaragemMoradia'];
    _animaisEstimacaoController.text =
        widget.moradia['moradia']['animaisEstimacaoMoradia'];
    _qtdMoradoresPermitidoController.text =
        widget.moradia['moradia']['qtdMoradoresPermitidoMoradia'].toString();
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update Moradia");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Moradia'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          print(widget.moradia['idArtefato']);
          return _atualizaMoradia();
        },
      ),
    );
  }

  Widget _atualizaMoradia() {
    final body = {
      "descricaoArtefato": _descricaoController.text,
      "tituloArtefato": _tituloController.text,
      "bairroMoradia": _bairroMoradiaController.text,
      "cepMoradia": _cepMoradiaController.text,
      "cidadeMoradia": _cidadeMoradiaController.text,
      "estadoMoradia": _estadoMoradiaController.text,
      "precoAluguelPorPessoaMoradia": _precoAluguelPorPessoaController.text,
      "precoAluguelTotalMoradia": _precoAluguelTotalController.text,
      "qtdMoradoresAtuaisMoradia": _qtdMoradoresAtuaisController.text,
      "qtdMoradoresPermitidoMoradia": _qtdMoradoresPermitidoController.text,
      "vagaGaragemMoradia": _vagaGaragemController.text,
      "animaisEstimacaoMoradia": _animaisEstimacaoController.text,
    };

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Titulo'),
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextFormField(
            controller: _estadoMoradiaController,
            decoration: const InputDecoration(labelText: 'Estado'),
          ),
          TextFormField(
            controller: _cidadeMoradiaController,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
          TextFormField(
            controller: _bairroMoradiaController,
            decoration: const InputDecoration(labelText: 'Bairro'),
          ),
          TextFormField(
            controller: _cepMoradiaController,
            decoration: const InputDecoration(labelText: 'CEP'),
          ),
          TextFormField(
            controller: _qtdMoradoresPermitidoController,
            decoration:
                const InputDecoration(labelText: 'Qtd Moradores Permitido'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _qtdMoradoresAtuaisController,
            decoration:
                const InputDecoration(labelText: 'Qtd Moradores Atuais'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _precoAluguelTotalController,
            decoration: const InputDecoration(labelText: 'Preço Aluguel Total'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _precoAluguelPorPessoaController,
            decoration:
                const InputDecoration(labelText: 'Preço Aluguel por Pessoa'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _vagaGaragemController,
            decoration: const InputDecoration(labelText: 'Vaga Garagem'),
          ),
          TextFormField(
            controller: _animaisEstimacaoController,
            decoration: const InputDecoration(labelText: 'Animais Estimação'),
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
                ImageHelper.updateImagem(widget.moradia['idArtefato'], imagem);
                await _moradiaRepository.updateMoradia(
                    body, widget.moradia['idArtefato']);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MoradiaPage()),
              );
            },
            child: const Text('Atualizar'),
          )
        ]),
      ),
    );
  }

  Future<void> _buscarMoradias() async {
    try {
      await MoradiaRepository().getAllMoradias();
      print("GetAllMoradias com sucesso em MoradiaCadastrarView");
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de Moradias em MoradiaCadastrarView: $e');
    }
  }
}
