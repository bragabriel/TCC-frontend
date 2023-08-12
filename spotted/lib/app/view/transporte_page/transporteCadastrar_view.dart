import 'package:flutter/material.dart';
import 'package:spotted/app/repository/transporte_repository.dart';

class TransporteCadastrarView extends StatefulWidget {
  @override
  _TransporteCadastrarViewState createState() =>
      _TransporteCadastrarViewState();
}

class _TransporteCadastrarViewState extends State<TransporteCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _cidadeTransporte = TextEditingController();
  final TextEditingController _periodoTransporte = TextEditingController();
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

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": 1, // PEGAR ID DO USUARIO
        "tipoArtefato": "TRANSPORTE",
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "cidadeTransporte":
          _cidadeTransporte.text.isNotEmpty ? _cidadeTransporte.text : null,
      "periodoTransporte":
          _periodoTransporte.text.isNotEmpty ? _periodoTransporte.text : null,
      "qtdAssentosPreenchidosTransporte":
          _qtdAssentosPreenchidosTransporteController.text.isNotEmpty
              ? double.parse(_qtdAssentosPreenchidosTransporteController.text)
              : null,
      "qtdAssentosTotalTransporte":
          _qtdAssentosTotalTransporteController.text.isNotEmpty
              ? double.parse(_qtdAssentosTotalTransporteController.text)
              : null,
      "telefoneUsuario": _telefoneUsuarioController.text.isNotEmpty
          ? double.parse(_telefoneUsuarioController.text)
          : null,
      "informacoesVeiculoTransporte":
          _informacoesVeiculoTransporteController.text.isNotEmpty
              ? double.parse(_informacoesVeiculoTransporteController.text)
              : null,
      "informacoesCondutorTransporte":
          _informacoesCondutorTransporteController.text.isNotEmpty
              ? double.parse(_informacoesCondutorTransporteController.text)
              : null,
    };

    try {
      await TransporteRepository().cadastrarTransporte(body);
      print('Cadastro realizado com sucesso');
    } catch (e) {
      print('Erro ao cadastrar: $e');
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _telefoneUsuarioController.dispose();
    _informacoesVeiculoTransporteController.dispose();
    _informacoesCondutorTransporteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar trasnporte'),
      ),
      body: SingleChildScrollView(
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
              controller: _cidadeTransporte,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _periodoTransporte,
              decoration: InputDecoration(labelText: 'Turno'),
            ),
            TextField(
              controller: _telefoneUsuarioController,
              decoration: InputDecoration(labelText: 'Contato'),
            ),
            TextField(
              controller: _informacoesVeiculoTransporteController,
              decoration: InputDecoration(labelText: 'Informações do veículo'),
            ),
            TextField(
              controller: _informacoesCondutorTransporteController,
              decoration: InputDecoration(labelText: 'Informações do condutor'),
            ),
            TextField(
              controller: _qtdAssentosPreenchidosTransporteController,
              decoration: InputDecoration(labelText: 'Assentos ocupados'),
            ),
            TextField(
              controller: _qtdAssentosTotalTransporteController,
              decoration: InputDecoration(labelText: 'Capacidade maxíma'),
            ),
            ElevatedButton(
              onPressed: _cadastrar,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
