import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/repository/festa_repository.dart';
import '../../controller/alimento_controller.dart';
import '../../model/artefato_model.dart';
import '../../model/festa_model.dart';
import '../home_page/home_view.dart';
import 'festaCadastrar_view.dart';
import 'festaDetalhe_view.dart';

class FestaPage extends StatefulWidget {
  const FestaPage({Key? key}) : super(key: key);

  @override
  State<FestaPage> createState() => FestaPageState();
}

class FestaPageState extends State<FestaPage> {
  List<Festa> festaList = [];
  List<Festa> filteredFestaList = [];
  String _searchTerm = '';
  String cidadeSelecionada = 'Selecione uma cidade';

  final _searchController = TextEditingController();
  final controller = AlimentoController();

  _success() {
    return _body();
  }

  _error() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ops, algo de errado aconteceu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.start();
            },
            child: Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
    _fetchFestas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Festas"), // Update the title
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
              controller.start();
              _fetchFestas();
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FestaCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return _filtros();
  }

  Future<void> _fetchFestas() async {
    try {
      final festaList = await FestaRepository().getAllFestas();
      setState(() {
        this.festaList = festaList;
        filteredFestaList = festaList;
      });
    } catch (e) {
      print('Erro ao obter a lista de festas: $e');
    }
  }

  void _filterFestaList() {
    setState(() {
      filteredFestaList = filteredFestaList.where((festa) {
        final atendeCriterioCidade =
            cidadeSelecionada == "Selecione uma cidade" ||
                festa.localizacaoFesta?.toLowerCase() ==
                    cidadeSelecionada.toLowerCase();

        final searchTerm = _searchTerm.toLowerCase();
        final titleContainsTerm =
            festa.tituloArtefato.toLowerCase().contains(searchTerm);
        final descriptionContainsTerm =
            festa.descricaoArtefato.toLowerCase().contains(searchTerm);

        return atendeCriterioCidade &&
            (titleContainsTerm || descriptionContainsTerm);
      }).toList();
    });
  }

  Column _filtros() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchTerm = value; // Update the _searchTerm variable
              _filterFestaList();
            });
          },
          decoration: InputDecoration(
            labelText: 'Pesquisar',
            prefixIcon: Icon(Icons.search),
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
                mainAxisSpacing: 20),
            itemCount: filteredFestaList.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FestaDetalhesView(filteredFestaList[index]);
                      },
                    ),
                  );
                },
                child: GridTile(
                  key: ValueKey(filteredFestaList[index].idArtefato),
                  footer: GridTileBar(
                    backgroundColor: const Color.fromARGB(137, 107, 98, 98),
                    title: Text(
                      filteredFestaList[index].tituloArtefato,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "R\$ ${filteredFestaList[index].localizacaoFesta}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: _buildImagens(filteredFestaList[index].listaImagens),
                ),
              );
            }),
      )
    ]);
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
}
