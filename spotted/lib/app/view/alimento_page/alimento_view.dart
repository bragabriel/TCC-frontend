import 'package:flutter/material.dart';
import 'package:spotted/app/repository/alimento_repository.dart';
import 'package:spotted/app/model/alimento_model.dart';
import '../../helpers/imageCarrousel_helper.dart';
import '../home_page/home_view.dart';
import 'alimentoCadastrar_view.dart';
import 'alimentoDetalhes_view.dart';
import '../../controller/alimento_controller.dart';

class AlimentoPage extends StatefulWidget {
  const AlimentoPage({Key? key}) : super(key: key);

  @override
  State<AlimentoPage> createState() => AlimentoPageState();
}

class AlimentoPageState extends State<AlimentoPage> {
  List<Alimento> foodList = [];
  List<Alimento> filteredFoodList = [];
  double? minPrice;
  double? maxPrice;
  bool showOnlyOffers = false;
  List<String> selectedTypes = [];
  bool _isSalgadoSelected = false;
  bool _isDoceSelected = false;
  bool _showAllItems = true;
  String _searchTerm = '';

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
    _buscarAlimentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alimentação"),
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
              _buscarAlimentos();
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
              builder: (context) => AlimentoCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return _filtros();
  }

  Future<void> _buscarAlimentos() async {
    try {
      final foodList = await AlimentoRepository().getAllAlimentos();
      setState(() {
        this.foodList = foodList;
        filteredFoodList = foodList;
      });
    } catch (e) {
      print('Erro ao obter a lista de alimentos: $e');
    }
  }

  void _alimentosFiltrados() {
    setState(() {
      filteredFoodList = foodList.where((food) {
        final meetsPriceCriteria =
            (minPrice == null || food.precoAlimento! >= minPrice!) &&
                (maxPrice == null || food.precoAlimento! <= maxPrice!);

        final meetsOfferCriteria = _showAllItems
            ? true // Sem filtro de oferta, mostrar todos os itens
            : food.ofertaAlimento?.isNotEmpty ??
                false; // Exibir apenas os itens em oferta

        final meetsTypeCriteria =
            (_isSalgadoSelected && food.tipoAlimento == 'SALGADO') ||
                (_isDoceSelected && food.tipoAlimento == 'DOCE') ||
                (!_isSalgadoSelected && !_isDoceSelected);

        final searchTerm = _searchTerm.toLowerCase();
        final titleContainsTerm =
            food.tituloArtefato.toLowerCase().contains(searchTerm);
        final descriptionContainsTerm =
            food.descricaoArtefato.toLowerCase().contains(searchTerm);

        return meetsPriceCriteria &&
            meetsOfferCriteria &&
            meetsTypeCriteria &&
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
              _alimentosFiltrados();
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
                      _alimentosFiltrados();
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
                      _alimentosFiltrados();
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
              Text('Oferta'),
              SizedBox(height: 4),
              Checkbox(
                value: !_showAllItems,
                onChanged: (value) {
                  setState(() {
                    _showAllItems = !value!;
                    _alimentosFiltrados();
                  });
                },
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 10),
      Wrap(
        spacing: 8,
        children: [
          FilterChip(
            label: Text('Salgado'),
            selected: _isSalgadoSelected,
            onSelected: (selected) {
              setState(() {
                _isSalgadoSelected = selected;
                _alimentosFiltrados();
              });
            },
          ),
          FilterChip(
            label: Text('Doce'),
            selected: _isDoceSelected,
            onSelected: (selected) {
              setState(() {
                _isDoceSelected = selected;
                _alimentosFiltrados();
              });
            },
          ),
        ],
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
            itemCount: filteredFoodList.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AlimentoDetalheView(filteredFoodList[index]);
                      },
                    ),
                  );
                },
                child: GridTile(
                  key: ValueKey(filteredFoodList[index].idArtefato),
                  footer: GridTileBar(
                    backgroundColor: const Color.fromARGB(137, 107, 98, 98),
                    title: Text(
                      filteredFoodList[index].tituloArtefato,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "R\$ ${filteredFoodList[index].precoAlimento}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: ImageHelper.buildCarrousel(
                      filteredFoodList[index].listaImagens),
                ),
              );
            }),
      )
    ]);
  }
}
