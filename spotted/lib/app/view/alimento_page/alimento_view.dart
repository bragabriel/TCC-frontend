import 'package:flutter/material.dart';
import 'package:spotted/app/repository/alimento_repository.dart';
import 'package:spotted/app/model/alimento_model.dart';

import 'alimentoCadastrar_view.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
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

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

  Future<void> _fetchFood() async {
    try {
      final foodList = await AlimentoRepository().getFood();
      setState(() {
        this.foodList = foodList;
        filteredFoodList = foodList;
      });
    } catch (e) {
      print('Erro ao obter a lista de alimentos: $e');
    }
  }

  bool _isTypeSelected(Alimento food) {
    // Se não houver tipos selecionados, todos os alimentos são válidos
    if (selectedTypes.isEmpty) {
      return true;
    }
    // Verifica se o tipo do alimento está na lista de tipos selecionados
    return selectedTypes.contains(food.tipoAlimento);
  }

  void _filterFoodList() {
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

        // Verifica se o termo de pesquisa está contido no título ou na descrição (ignorando maiúsculas e minúsculas)
        final searchTerm = _searchTerm.toLowerCase();
        final titleContainsTerm =
            food.tituloArtefato.toLowerCase().contains(searchTerm);
        final descriptionContainsTerm =
            food.descricaoArtefato.toLowerCase().contains(searchTerm);

        // Retorna true apenas se o alimento atender a todos os critérios de filtragem
        return meetsPriceCriteria &&
            meetsOfferCriteria &&
            meetsTypeCriteria &&
            (titleContainsTerm || descriptionContainsTerm);

      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alimentação"),
        actions: [
          IconButton(
            onPressed: () {
              _fetchFood();
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchTerm = value; // Update the _searchTerm variable
                  _filterFoodList();
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
                          _filterFoodList();
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
                          _filterFoodList();
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
                        _filterFoodList();
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
                    _filterFoodList();
                  });
                },
              ),
              FilterChip(
                label: Text('Doce'),
                selected: _isDoceSelected,
                onSelected: (selected) {
                  setState(() {
                    _isDoceSelected = selected;
                    _filterFoodList();
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(
                filteredFoodList.length,
                (index) => Card(
                  elevation: 2,
                  color: Colors.orange[100 + (index % 4) * 100],
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredFoodList[index].tituloArtefato,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Descrição: ${filteredFoodList[index].descricaoArtefato}',
                          ),
                          Text(
                            'Tipo: ${filteredFoodList[index].tipoAlimento}',
                          ),
                          Text(
                            'Marca: ${filteredFoodList[index].marcaAlimento}',
                          ),
                          Text(
                            'Sabor: ${filteredFoodList[index].saborAlimento}',
                          ),
                          Text(
                            'Unidade: ${filteredFoodList[index].unidadeAlimento}',
                          ),
                          Text(
                            'Preço: R\$ ${filteredFoodList[index].precoAlimento?.toStringAsFixed(2) ?? '0.00'}',
                          ),
                          Text(
                            'Oferta: ${filteredFoodList[index].ofertaAlimento}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
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
}
