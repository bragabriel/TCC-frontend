import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/transporte_page/transporte_view.dart';
import '../../../service/user_provider.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/transporte_repository.dart';

class TransporteEditarView extends StatefulWidget {
  final dynamic transporte;

  const TransporteEditarView(this.transporte, {super.key});

  @override
  TransporteEditarPageState createState() => TransporteEditarPageState();
}

class TransporteEditarPageState extends State<TransporteEditarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _cidadeTransporteController =
      TextEditingController();
  final TextEditingController _periodoTransporteController =
      TextEditingController();
  final TextEditingController _qtdAssentosPreenchidosTransporteController =
      TextEditingController();
  final TextEditingController _qtdAssentosTotalTransporteController =
      TextEditingController();
  final TextEditingController _informacoesVeiculoTransporteController =
      TextEditingController();
  final TextEditingController _informacoesCondutorTransporteController =
      TextEditingController();
  final TextEditingController _valorTransporteController =
      TextEditingController();
  final TransporteRepository _transporteRepository = TransporteRepository();
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
    _tituloController.dispose();
    _descricaoController.dispose();
    _cidadeTransporteController.dispose();
    _periodoTransporteController.dispose();
    _qtdAssentosPreenchidosTransporteController.dispose();
    _qtdAssentosTotalTransporteController.dispose();
    // _telefoneUsuarioController.dispose();
    _informacoesVeiculoTransporteController.dispose();
    _informacoesCondutorTransporteController.dispose();
    _valorTransporteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _descricaoController.text = widget.transporte['descricaoArtefato'];
    _tituloController.text = widget.transporte['tituloArtefato'];
    _cidadeTransporteController.text =
        widget.transporte['transporte']['cidadeTransporte'];
    _periodoTransporteController.text =
        widget.transporte['transporte']['periodoTransporte'];
    _qtdAssentosPreenchidosTransporteController.text = widget
        .transporte['transporte']['qtdAssentosPreenchidosTransporte']
        .toString();
    _qtdAssentosTotalTransporteController.text = widget.transporte['transporte']
            ['qtdAssentosTotalTransporte']
        .toString();
    _informacoesVeiculoTransporteController.text =
        widget.transporte['transporte']['informacoesVeiculoTransporte'];
    _informacoesCondutorTransporteController.text =
        widget.transporte['transporte']['informacoesCondutorTransporte'];
    _valorTransporteController.text =
        widget.transporte['transporte']['valorTransporte'];
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update Transporte");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Transporte'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          print(widget.transporte['idArtefato']);
          return _atualizaTransporte();
        },
      ),
    );
  }

  Widget _atualizaTransporte() {
    final body = {
      "descricaoArtefato": _descricaoController.text,
      "tituloArtefato": _tituloController.text,
      "cidadeTransporte": _cidadeTransporteController.text,
      "periodoTransporte": _periodoTransporteController.text,
      "qtdAssentosPreenchidosTransporte":
          _qtdAssentosPreenchidosTransporteController.text,
      "qtdAssentosTotalTransporte": _qtdAssentosTotalTransporteController.text,
      "informacoesVeiculoTransporte":
          _informacoesVeiculoTransporteController.text,
      "informacoesCondutorTransporte":
          _informacoesCondutorTransporteController.text,
      "valorTransporte": _valorTransporteController.text,
    };
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(
            controller: _tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextFormField(
            controller: _cidadeTransporteController,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
          TextFormField(
            controller: _periodoTransporteController,
            decoration: const InputDecoration(labelText: 'Turno'),
          ),
          TextFormField(
            controller: _informacoesVeiculoTransporteController,
            decoration:
                const InputDecoration(labelText: 'Informações do veículo'),
          ),
          TextFormField(
            controller: _informacoesCondutorTransporteController,
            decoration:
                const InputDecoration(labelText: 'Informações do condutor'),
          ),
          TextFormField(
            controller: _qtdAssentosPreenchidosTransporteController,
            decoration: const InputDecoration(labelText: 'Assentos ocupados'),
          ),
          TextFormField(
            controller: _qtdAssentosTotalTransporteController,
            decoration: const InputDecoration(labelText: 'Capacidade maxíma'),
          ),
          TextFormField(
            controller: _valorTransporteController,
            decoration: const InputDecoration(labelText: 'Valor'),
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
                ImageHelper.updateImagem(widget.transporte['idArtefato'], imagem);
                await _transporteRepository.updateTransporte(
                    body, widget.transporte['idArtefato']);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TransportePage()),
              );
            },
            child: const Text('Atualizar'),
          )
        ]),
      ),
    );
  }
}
