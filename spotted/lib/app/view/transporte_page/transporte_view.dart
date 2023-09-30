import 'package:flutter/material.dart';
import 'package:spotted/app/view/transporte_page/transporteCadastrar_view.dart';
import '../../helpers/image_helper.dart';
import '../../model/transporte_model.dart';
import '../../repository/transporte_repository.dart';
import '../home_page/home_view.dart';
import 'TransporteDetalhe_view.dart';

class TransportePage extends StatefulWidget {
  const TransportePage({Key? key}) : super(key: key);
  
  @override
  TransportePageState createState() => TransportePageState();
}

class TransportePageState extends State<TransportePage> {
  List<Transporte> listaDeTransportes = [];
  List<Transporte> listaFiltradaDeTransportes = [];
  String cidadeSelecionada = 'Selecione uma cidade';
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _buscarTransportes();
  }

  Future<void> _buscarTransportes() async {
    try {
      final listaDeTransportes =
          await TransporteRepository().getAllTransportes();
      setState(() {
        this.listaDeTransportes = listaDeTransportes;
        listaFiltradaDeTransportes = listaDeTransportes;
      });
    } catch (e) {
      print('Erro ao obter a lista de Transportes: $e');
    }
  }

  List<String> _obterListaDeCidades() {
    final cidades = listaDeTransportes
        .map((Transporte) => Transporte.cidadeTransporte)
        .where((cidade) => cidade != null)
        .map((cidade) => cidade!)
        .toSet()
        .toList();

    cidades.insert(0, "Selecione uma cidade");

    return cidades;
  }

  void _filtrarListaDeTransportes() {
    setState(() {
      listaFiltradaDeTransportes = listaDeTransportes.where((transporte) {
        final atendeCriterioCidade =
            cidadeSelecionada == "Selecione uma cidade" ||
                transporte.cidadeTransporte?.toLowerCase() ==
                    cidadeSelecionada.toLowerCase();

      final searchTerm = _searchTerm.toLowerCase();
            final titleContainsTerm =
                transporte.tituloArtefato.toLowerCase().contains(searchTerm);
            final descriptionContainsTerm =
                transporte.descricaoArtefato.toLowerCase().contains(searchTerm);
                
        return atendeCriterioCidade &&
            (titleContainsTerm || descriptionContainsTerm);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transportes"),
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
              _buscarTransportes();
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
              builder: (context) => TransporteCadastrarView(),
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
                _searchTerm = valor;
              _filtrarListaDeTransportes();
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
                _filtrarListaDeTransportes();
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
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: listaFiltradaDeTransportes.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TransporteDetalheView(
                              listaFiltradaDeTransportes[index]);
                        },
                      ),
                    );
                  },
                  child: GridTile(
                    key: ValueKey(listaFiltradaDeTransportes[index].idArtefato),
                    footer: GridTileBar(
                      backgroundColor: const Color.fromARGB(137, 107, 98, 98),
                      title: Text(
                        listaFiltradaDeTransportes[index].tituloArtefato,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        listaFiltradaDeTransportes[index].cidadeTransporte ??
                            "Cidade não disponível",
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    child: ImageHelper.buildCarrousel(
                        listaDeTransportes[index].listaImagens),
                  ));
            },
          ),
        ),
      ],
    );
  }
}