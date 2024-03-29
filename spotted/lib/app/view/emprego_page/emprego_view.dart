import 'package:flutter/material.dart';
import 'package:spotted/app/constants/constants.dart';
import 'package:spotted/app/helpers/image_helper.dart';
import 'package:spotted/app/repository/emprego_repository.dart';
import 'package:spotted/app/model/emprego_model.dart';
import 'empregoCadastrar_view.dart';
import '../home_page/home_view.dart';
import 'empregoDetalhe_view.dart';

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
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _carregarEmpregos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empregos"),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
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
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmpregoCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Future<void> _carregarEmpregos() async {
    try {
      final listaDeEmpregos = await EmpregoRepository().getAllEmpregos();
      print("GetAllEmpregos com sucesso em EmpregoPage");
      setState(() {
        this.listaDeEmpregos = listaDeEmpregos;
        listaFiltradaDeEmpregos = listaDeEmpregos;
      });
    } catch (e) {
      print('Erro ao obter a lista de empregos em EmpregoPage: $e');
    }
  }

  List<String> _obterListaDeCidades() {
    final cidades = listaDeEmpregos
        .map((emprego) => emprego.cidadeEmprego)
        .where((cidade) => cidade != null)
        .map((cidade) => cidade!)
        .toSet()
        .toList();

    cidades.insert(0, "Selecione uma cidade");

    return cidades;
  }

  List<String> _obterListaDeEmpresas() {
    final empresas = listaDeEmpregos
        .map((emprego) => emprego.empresaEmprego)
        .where((empresa) => empresa != null)
        .map((empresa) => empresa!)
        .toSet()
        .toList();

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
            presencialSelecionado == "Todos" ||
            emprego.presencialEmprego?.toLowerCase() ==
                presencialSelecionado?.toLowerCase();

        final atendeCriterioSalario = (salarioMinimo == null ||
                emprego.salarioEmprego! >= salarioMinimo!) &&
            (salarioMaximo == null ||
                emprego.salarioEmprego! <= salarioMaximo!);

        final searchTerm = _searchTerm.toLowerCase();
        final titleContainsTerm =
            emprego.tituloArtefato.toLowerCase().contains(searchTerm);
        final descriptionContainsTerm =
            emprego.descricaoArtefato.toLowerCase().contains(searchTerm);

        return atendeCriterioCidade &&
            atendeCriterioEmpresa &&
            atendeCriterioPresencial &&
            atendeCriterioSalario &&
            (titleContainsTerm || descriptionContainsTerm);
      }).toList();
    });
  }

  Widget _construirFiltrosELista() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchTerm = value;
                _filtrarListaDeEmpregos();
              });
            },
            decoration: const InputDecoration(
              labelText: 'Pesquisar',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
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
            decoration: const InputDecoration(
              labelText: 'Cidade',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
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
            decoration: const InputDecoration(
              labelText: 'Empresa',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
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
            items: const [
              DropdownMenuItem<String>(
                value: "Todos",
                child: Text("Todos"),
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
            decoration: const InputDecoration(
              labelText: 'Presencial/Remoto',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
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
              return InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EmpregoDetalheView(
                              listaFiltradaDeEmpregos[index]);
                        },
                      ),
                    );
                  },
                  child: GridTile(
                    key: ValueKey(listaFiltradaDeEmpregos[index].idArtefato),
                    footer: GridTileBar(
                      backgroundColor: cardColor,
                      title: Text(
                        listaFiltradaDeEmpregos[index].tituloArtefato,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        listaFiltradaDeEmpregos[index].cidadeEmprego ??
                            "Cidade não disponível",
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    child: ImageHelper.loadImage(
                        listaDeEmpregos[index].listaImagens),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
