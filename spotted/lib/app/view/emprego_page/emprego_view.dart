import 'package:flutter/material.dart';
import 'package:spotted/app/repository/emprego_repository.dart';
import 'package:spotted/app/model/emprego_model.dart';

import 'empregoCadastrar_view.dart';

class EmpregoPage extends StatefulWidget {
  const EmpregoPage({Key? key}) : super(key: key);

  @override
  _EmpregoPageState createState() => _EmpregoPageState();
}

class _EmpregoPageState extends State<EmpregoPage> {
  List<Emprego> listaDeEmpregos = [];
  List<Emprego> listaFiltradaDeEmpregos = [];
  String cidadeSelecionada = 'Selecione uma cidade';
  String empresaSelecionada = 'Selecione uma empresa';
  String? presencialSelecionado;
  double? salarioMinimo;
  double? salarioMaximo;

  @override
  void initState() {
    super.initState();
    _carregarEmpregos();
  }

  Future<void> _carregarEmpregos() async {
    try {
      final listaDeEmpregos = await EmpregoRepository().getAllEmpregos();
      setState(() {
        this.listaDeEmpregos = listaDeEmpregos;
        listaFiltradaDeEmpregos = listaDeEmpregos;
      });
    } catch (e) {
      print('Erro ao obter a lista de empregos: $e');
    }
  }

  List<String> _obterListaDeCidades() {
    final cidades = listaDeEmpregos
        .map((emprego) => emprego.cidadeEmprego)
        .where((cidade) => cidade != null) // Remover valores nulos
        .map((cidade) => cidade!) // Converter String? para String
        .toSet() // Remover valores duplicados
        .toList();

    // Adicionar valor padrão "Selecione uma cidade" no início da lista
    cidades.insert(0, "Selecione uma cidade");

    return cidades;
  }

  List<String> _obterListaDeEmpresas() {
    final empresas = listaDeEmpregos
        .map((emprego) => emprego.empresaEmprego)
        .where((empresa) => empresa != null) // Remover valores nulos
        .map((empresa) => empresa!) // Converter String? para String
        .toSet() // Remover valores duplicados
        .toList();

    // Adicionar valor padrão "Selecione uma empresa" no início da lista
    empresas.insert(0, "Selecione uma empresa");

    return empresas;
  }

  void _filtrarListaDeEmpregos() {
    setState(() {
      listaFiltradaDeEmpregos = listaDeEmpregos.where((emprego) {
        final atendeCriterioCidade =
            cidadeSelecionada == "Selecione uma cidade" ||
                emprego.cidadeEmprego?.toLowerCase() ==
                    cidadeSelecionada.toLowerCase();

        final atendeCriterioEmpresa =
            empresaSelecionada == "Selecione uma empresa" ||
                emprego.empresaEmprego?.toLowerCase() ==
                    empresaSelecionada.toLowerCase();

        final atendeCriterioPresencial = presencialSelecionado == null ||
            presencialSelecionado == "TODOS" ||
            emprego.presencialEmprego?.toLowerCase() ==
                presencialSelecionado?.toLowerCase();

        final atendeCriterioSalario = (salarioMinimo == null ||
                emprego.salarioEmprego! >= salarioMinimo!) &&
            (salarioMaximo == null ||
                emprego.salarioEmprego! <= salarioMaximo!);

        return atendeCriterioCidade &&
            atendeCriterioEmpresa &&
            atendeCriterioPresencial &&
            atendeCriterioSalario;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Empregos"),
        actions: [
          IconButton(
            onPressed: () {
              _carregarEmpregos();
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: _construirFiltrosELista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmpregoCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Widget _construirFiltrosELista() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (valor) {
              setState(() {
                // Implemente o filtro por título aqui, se necessário
              });
            },
            decoration: InputDecoration(
              labelText: 'Pesquisar',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: cidadeSelecionada,
            onChanged: (novaCidade) {
              setState(() {
                cidadeSelecionada = novaCidade!;
                _filtrarListaDeEmpregos();
              });
            },
            items:
                _obterListaDeCidades().map<DropdownMenuItem<String>>((cidade) {
              return DropdownMenuItem<String>(
                value: cidade,
                child: Text(cidade),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Cidade',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: empresaSelecionada,
            onChanged: (novaEmpresa) {
              setState(() {
                empresaSelecionada = novaEmpresa!;
                _filtrarListaDeEmpregos();
              });
            },
            items: _obterListaDeEmpresas()
                .map<DropdownMenuItem<String>>((empresa) {
              return DropdownMenuItem<String>(
                value: empresa,
                child: Text(empresa),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Empresa',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: presencialSelecionado,
            onChanged: (novaSelecao) {
              setState(() {
                presencialSelecionado = novaSelecao!;
                _filtrarListaDeEmpregos();
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: "TODOS",
                child: Text("TODOS"),
              ),
              DropdownMenuItem<String>(
                value: "Presencial",
                child: Text("Presencial"),
              ),
              DropdownMenuItem<String>(
                value: "Remoto",
                child: Text("Remoto"),
              ),
              DropdownMenuItem<String>(
                value: "Híbrido",
                child: Text("Híbrido"),
              ),
            ],
            decoration: InputDecoration(
              labelText: 'Presencial/Remoto',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: listaFiltradaDeEmpregos.length,
            itemBuilder: (BuildContext ctx, index) {
              return GridTile(
                key: ValueKey(listaFiltradaDeEmpregos[index].idArtefato),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    listaFiltradaDeEmpregos[index].tituloArtefato,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(listaFiltradaDeEmpregos[index].cidadeEmprego ??
                      "Cidade não disponível"),
                ),
                child: Image.asset(
                  'assets/images/jobs.jpg',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
