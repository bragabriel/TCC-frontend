import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/change_notifier.dart';
import '../../model/usuario_model.dart';
import '../../repository/alimento_repository.dart';
import 'alimento_view.dart';

class AlimentoCadastrarView extends StatefulWidget {
  const AlimentoCadastrarView({super.key});

  @override
  AlimentoCadastrarPageState createState() => AlimentoCadastrarPageState();
}

class AlimentoCadastrarPageState extends State<AlimentoCadastrarView> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _saborController = TextEditingController();
  final TextEditingController _unidadeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _ofertaController = TextEditingController();

  int? idUsuario;
  String _selectedTipo = 'OUTRO'; // Valor selecionado para o tipo de alimento
  String _selectedUnidade =
      'OUTRO'; // Valor selecionado para a unidade de alimento

  Future<void> _cadastrar() async {
    final body = {
      "artefato": {
        "descricaoArtefato": _descricaoController.text.isNotEmpty
            ? _descricaoController.text
            : null,
        "idUsuario": idUsuario,
        "tituloArtefato":
            _tituloController.text.isNotEmpty ? _tituloController.text : null,
      },
      "marcaAlimento":
          _marcaController.text.isNotEmpty ? _marcaController.text : null,
      "ofertaAlimento":
          _ofertaController.text.isNotEmpty ? _ofertaController.text : null,
      "precoAlimento": _precoController.text.isNotEmpty
          ? double.parse(_precoController.text)
          : null,
      "saborAlimento":
          _saborController.text.isNotEmpty ? _saborController.text : null,
      "tipoAlimento":
          _tipoController.text.isNotEmpty ? _tipoController.text : null,
      "unidadeAlimento":
          _unidadeController.text.isNotEmpty ? _unidadeController.text : null,
    };

    try {
      await AlimentoRepository().cadastrarAlimento(body);
      print('Cadastro realizado com sucesso');
    } catch (e) {
      print('Erro ao cadastrar: $e');
    }
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

  Future<void> _fetchFood() async {
    try {
      await AlimentoRepository().getAllAlimentos();
      setState(() {});
    } catch (e) {
      print('Erro ao obter a lista de alimentos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar alimento'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          idUsuario = _getUser(context, userProvider);
          print("idUsuario: $idUsuario"); // Imprimir o ID do usuário
          return _cadastroAlimento();
        },
      ),
    );
  }

  SingleChildScrollView _cadastroAlimento() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Titulo'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedTipo,
            onChanged: (String? newValue) {
              setState(() {
                _selectedTipo = newValue ?? '';
              });
            },
            items: <String>[
              'DOCE',
              'SALGADO',
              'OUTRO'
            ] // Substitua pelas opções reais
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
          SizedBox(height: 16),
          TextField(
            controller: _marcaController,
            decoration: InputDecoration(labelText: 'Marca'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _saborController,
            decoration: InputDecoration(labelText: 'Sabor'),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedUnidade,
            onChanged: (String? newValue) {
              setState(() {
                _selectedUnidade = newValue ?? '';
              });
            },
            items: <String>[
              'PEDAÇO',
              'UNIDADE',
              'PACK',
              'OUTRO'
            ] // Substitua pelas opções reais
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
          TextField(
            controller: _precoController,
            decoration: InputDecoration(labelText: 'Preço'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _ofertaController,
            decoration: InputDecoration(labelText: 'Oferta'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Confirmação de cadastro"),
                    content: Text("Deseja cadastrar o alimento?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlimentoPage()),
                          ).then((value) {
                            _fetchFood();
                          });
                          _cadastrar();
                        },
                        child: Text("Sim"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancelar"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }

  int? _getUser(BuildContext context, UserProvider userProvider) {
    Usuario? user = userProvider.user;
    return user?.idUsuario;
  }
}
