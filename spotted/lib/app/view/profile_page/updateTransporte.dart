import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/controller/transporte_controller.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../../repository/transporte_repository.dart';

class TransporteEditarView extends StatefulWidget {
  final dynamic Transporte;

  TransporteEditarView(this.Transporte);

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
  final TextEditingController _telefoneUsuarioController =
      TextEditingController();
  final TextEditingController _informacoesVeiculoTransporteController =
      TextEditingController();
  final TextEditingController _informacoesCondutorTransporteController =
      TextEditingController();
  final TextEditingController _valorTransporteController =
      TextEditingController();
  final TransporteRepository _transporteRepository = TransporteRepository();
  Response<dynamic>? response;
  late File? imagem;
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
    _tituloController.dispose();
    _descricaoController.dispose();
    _cidadeTransporteController.dispose();
    _periodoTransporteController.dispose();
    _qtdAssentosPreenchidosTransporteController.dispose();
    _qtdAssentosTotalTransporteController.dispose();
    _telefoneUsuarioController.dispose();
    _informacoesVeiculoTransporteController.dispose();
    _informacoesCondutorTransporteController.dispose();
    _valorTransporteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _descricaoController.text = widget.Transporte['descricaoArtefato'];
    _tituloController.text = widget.Transporte['tituloArtefato'];
    _cidadeTransporteController.text =
        widget.Transporte['transporte']['cidadeTransporte'];
    _periodoTransporteController.text =
        widget.Transporte['transporte']['periodoTransporte'];
    _qtdAssentosPreenchidosTransporteController.text =
        widget.Transporte['transporte']['qtdAssentosPreenchidosTransporte'];
    _qtdAssentosTotalTransporteController.text =
        widget.Transporte['transporte']['qtdAssentosTotalTransporte'];
    _telefoneUsuarioController.text =
        widget.Transporte['transporte']['telefoneUsuarioTransporte'];
    _informacoesVeiculoTransporteController.text =
        widget.Transporte['transporte']['informacoesVeiculoTransporte'];
    _informacoesCondutorTransporteController.text =
        widget.Transporte['transporte']['informacoesCondutorTransporte'];
    _valorTransporteController.text =
        widget.Transporte['transporte']['valorTransporte'];
  }

  @override
  Widget build(BuildContext context) {
    print("entrou no update Transporte");
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Transporte'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          print(widget.Transporte['idArtefato']);
          return _atualizaTransporte();
        },
      ),
    );
  }

  Widget _atualizaTransporte() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextFormField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextFormField(
            controller: _cidadeTransporteController,
            decoration: InputDecoration(labelText: 'Cidade'),
          ),
          TextFormField(
            controller: _periodoTransporteController,
            decoration: InputDecoration(labelText: 'Turno'),
          ),
          TextFormField(
            controller: _informacoesVeiculoTransporteController,
            decoration: InputDecoration(labelText: 'Informações do veículo'),
          ),
          TextFormField(
            controller: _informacoesCondutorTransporteController,
            decoration: InputDecoration(labelText: 'Informações do condutor'),
          ),
          TextFormField(
            controller: _qtdAssentosPreenchidosTransporteController,
            decoration: InputDecoration(labelText: 'Assentos ocupados'),
          ),
          TextFormField(
            controller: _qtdAssentosTotalTransporteController,
            decoration: InputDecoration(labelText: 'Capacidade maxíma'),
          ),
          TextFormField(
            controller: _valorTransporteController,
            decoration: InputDecoration(labelText: 'Valor'),
          ),
          ElevatedButton(
            onPressed: () async {
              var descricaoArtefato = _descricaoController.text;
              var tituloArtefato = _tituloController.text;

              var cidadeTransporte = _cidadeTransporteController.text;
              var periodoTransporte = _periodoTransporteController.text;
              var qtdAssentosPreenchidosTransporte =
                  _qtdAssentosPreenchidosTransporteController.text;
              var qtdAssentosTotalTransporte =
                  _qtdAssentosTotalTransporteController.text;
              var telefoneUsuario = _telefoneUsuarioController.text;
              var informacoesVeiculoTransporte =
                  _informacoesVeiculoTransporteController.text;
              var informacoesCondutorTransporte =
                  _informacoesCondutorTransporteController.text;
              var valorTransporte = _valorTransporteController.text;

              try {
                await _transporteRepository.updateTransporte(
                    widget.Transporte['idArtefato'],
                    descricaoArtefato,
                    tituloArtefato,
                    cidadeTransporte,
                    informacoesCondutorTransporte,
                    informacoesVeiculoTransporte,
                    periodoTransporte,
                    qtdAssentosPreenchidosTransporte as int,
                    qtdAssentosTotalTransporte as int,
                    valorTransporte);
                _showSuccessMessage(context);
              } catch (e) {
                print(e);
              }
              await _buscarTransportes();
              Navigator.pop(context);
            },
            child: Text('Atualizar'),
          )
        ]),
      ),
    );
  }

  Future<void> _buscarTransportes() async {
    try {
      await TransporteRepository().getAllTransportes();
      print("GetAllTransportes com sucesso em TransporteCadastrarView");
      setState(() {});
    } catch (e) {
      print(
          'Erro ao obter a lista de Transportes em TransporteCadastrarView: $e');
    }
  }
}
