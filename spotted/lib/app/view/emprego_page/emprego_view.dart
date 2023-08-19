import 'package:flutter/material.dart';
import 'package:spotted/app/repository/emprego_repository.dart';
import 'package:spotted/app/model/emprego_model.dart';
import 'package:spotted/app/view/emprego_page/empregoDetalhe_view.dart';
import '../../helpers/image_helper.dart';
import '../home_page/home_view.dart';
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
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
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
              setState(() {});
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
                      backgroundColor: const Color.fromARGB(137, 107, 98, 98),
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
                    child: ImageHelper.buildCarrousel(
                        listaDeEmpregos[index].listaImagens),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
