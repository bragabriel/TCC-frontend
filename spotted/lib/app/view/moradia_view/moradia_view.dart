import 'package:flutter/material.dart';
import 'package:spotted/app/repository/moradia_repository.dart';
import 'package:spotted/app/model/moradia_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../controller/moradia_controller.dart';
import '../../model/artefato_model.dart';
import 'moradiaCadastrar_view.dart';
import 'moradiaDetalhe_view.dart';

class MoradiaPage extends StatefulWidget {
  const MoradiaPage({Key? key}) : super(key: key);

  @override
  State<MoradiaPage> createState() => MoradiaPageState();
}

class MoradiaPageState extends State<MoradiaPage> {
  List<Moradia> moradiaList = [];
  List<Moradia> filteredMoradiaList = [];
  double? minPrice;
  double? maxPrice;
  bool showOnlyOffers = false;
  List<String> selectedTypes = [];
  int? qtdMoradoresFilter;
  bool _showAllItems = true;
  String _searchTerm = '';
  String cidadeSelecionada = 'Selecione uma cidade';
  String estadoSelecionado = 'Selecione um estado';

  final _searchController = TextEditingController();
  final controller = MoradiaController();

  _success() {
    return _filtros();
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
    _fetchMoradia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moradia"),
        actions: [
          IconButton(
            onPressed: () {
              controller.start();
              _fetchMoradia();
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
              builder: (context) => MoradiaCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Future<void> _fetchMoradia() async {
    try {
      final moradiaList = await MoradiaRepository().getAllMoradias();
      setState(() {
        this.moradiaList = moradiaList;
        filteredMoradiaList = moradiaList;
      });
    } catch (e) {
      print('Erro ao obter a lista de moradias: $e');
    }
  }

  void _filterMoradiaList() {
    setState(() {
      filteredMoradiaList = moradiaList.where((moradia) {
        final meetsPriceCriteria = (minPrice == null ||
                moradia.precoAluguelTotalMoradia! >= minPrice!) &&
            (maxPrice == null ||
                moradia.precoAluguelTotalMoradia! <= maxPrice!);

        final meetsMoradoresCriteria = (qtdMoradoresFilter == null ||
            moradia.qtdMoradoresAtuaisMoradia! >= qtdMoradoresFilter!);

        final meetsCidadeCriteria =
            cidadeSelecionada == "Selecione uma cidade" ||
                moradia.cidadeMoradia?.toLowerCase() ==
                    cidadeSelecionada.toLowerCase();

        final meetsEstadoCriteria =
            estadoSelecionado == "Selecione um estado" ||
                moradia.estadoMoradia?.toLowerCase() ==
                    estadoSelecionado.toLowerCase();

        final searchTerm = _searchTerm.toLowerCase();
        final titleContainsTerm =
            moradia.tituloArtefato.toLowerCase().contains(searchTerm);
        final descriptionContainsTerm =
            moradia.descricaoArtefato.toLowerCase().contains(searchTerm);

        return meetsPriceCriteria &&
            meetsMoradoresCriteria &&
            meetsCidadeCriteria &&
            meetsEstadoCriteria &&
            (titleContainsTerm || descriptionContainsTerm);
      }).toList();
    });
  }

  Column _filtros() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchTerm = value; // Update the _searchTerm variable
                _filterMoradiaList();
              });
            },
            decoration: InputDecoration(
              labelText: 'Pesquisar',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Preço mínimo'),
                SizedBox(height: 4),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        minPrice = value.isEmpty ? null : double.parse(value);
                        _filterMoradiaList();
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '0.0',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('Preço máximo'),
                SizedBox(height: 4),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        maxPrice = value.isEmpty ? null : double.parse(value);
                        _filterMoradiaList();
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '0.0',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        // Filtro qtdMoradoresAtuaisMoradia
        Column(
          children: [
            Text('Quantidade Max de Moradores Atuais'),
            SizedBox(height: 4),
            SizedBox(
              width: 100,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    qtdMoradoresFilter =
                        value.isEmpty ? null : int.parse(value);
                    _filterMoradiaList();
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '0',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: cidadeSelecionada,
            onChanged: (novaCidade) {
              setState(() {
                cidadeSelecionada = novaCidade!;
                _filterMoradiaList();
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

        // Filtro por Estado
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: estadoSelecionado,
            onChanged: (novoEstado) {
              setState(() {
                estadoSelecionado = novoEstado!;
                _filterMoradiaList();
              });
            },
            items:
                _obterListaDeEstados().map<DropdownMenuItem<String>>((estado) {
              return DropdownMenuItem<String>(
                value: estado,
                child: Text(estado),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Estado',
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
            itemCount: filteredMoradiaList.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MoradiaDetalheView(filteredMoradiaList[index]);
                      },
                    ),
                  );
                },
                child: GridTile(
                  key: ValueKey(filteredMoradiaList[index].idArtefato),
                  footer: GridTileBar(
                    backgroundColor: const Color.fromARGB(137, 107, 98, 98),
                    title: Text(
                      filteredMoradiaList[index].tituloArtefato,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "R\$ ${filteredMoradiaList[index].precoAluguelTotalMoradia}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  child: _buildImagens(filteredMoradiaList[index].listaImagens),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  List<String> _obterListaDeCidades() {
    final cidades = moradiaList
        .map((moradia) => moradia.cidadeMoradia)
        .where((cidade) => cidade != null) // Remover valores nulos
        .map((cidade) => cidade!) // Converter String? para String
        .toSet() // Remover valores duplicados
        .toList();

    // Adicionar valor padrão "Selecione uma cidade" no início da lista
    cidades.insert(0, "Selecione uma cidade");

    return cidades;
  }

  List<String> _obterListaDeEstados() {
    final estados = moradiaList
        .map((moradia) => moradia.estadoMoradia)
        .where((estado) => estado != null) // Remover valores nulos
        .map((estado) => estado!) // Converter String? para String
        .toSet() // Remover valores duplicados
        .toList();

    // Adicionar valor padrão "Selecione um estado" no início da lista
    estados.insert(0, "Selecione um estado");

    return estados;
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
              items: listaDeImagens?.map((imagemPath) {
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
        child: Image.asset('assets/images/imagem_nao_cadastrada.png'),
      );
    }
  }
}
