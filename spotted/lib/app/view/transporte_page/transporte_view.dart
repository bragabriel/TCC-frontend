import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/view/transporte_page/transporteCadastrar_view.dart';
import '../../model/artefato_model.dart';
import '../../model/transporte_model.dart';
import '../../repository/transporte_repository.dart';
import '../home_page/home_view.dart';
import 'TransporteDetalhe_view.dart';

class TransportePage extends StatefulWidget {
  const TransportePage({Key? key}) : super(key: key);

  @override
  _TransportePageState createState() => _TransportePageState();
}

class _TransportePageState extends State<TransportePage> {
  List<Transporte> listaDeTransportes = [];
  List<Transporte> listaFiltradaDeTransportes = [];
  String cidadeSelecionada = 'Selecione uma cidade';

  @override
  void initState() {
    super.initState();
    _carregarTransportes();
  }

  Future<void> _carregarTransportes() async {
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
      listaFiltradaDeTransportes = listaDeTransportes.where((Transporte) {
        final atendeCriterioCidade =
            cidadeSelecionada == "Selecione uma cidade" ||
                Transporte.cidadeTransporte?.toLowerCase() ==
                    cidadeSelecionada.toLowerCase();

        return atendeCriterioCidade;
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
              _carregarTransportes();
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
                    child:
                        _buildImagens(listaDeTransportes[index].listaImagens),
                  ));
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildImagens(List<Imagem>? listaDeImagens) {
  if (!listaDeImagens!.isEmpty) {
    final imageAspectRatio = 2 / 3;
    return Scaffold(
      body: AspectRatio(
        aspectRatio: imageAspectRatio,
        child: Container(
          width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInExpo,
              pauseAutoPlayOnTouch: true,
            ),
            items: listaDeImagens.map((imagemPath) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(
                    imagemPath.url,
                    fit: BoxFit.cover,
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  } else {
    return Center(
      child: Image.asset('assets/images/imagem.png'),
    );
  }
}
