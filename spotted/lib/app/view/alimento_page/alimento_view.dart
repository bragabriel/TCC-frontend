import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotted/app/controller/alimento_controller.dart';
import 'package:spotted/app/model/alimento_model.dart';
import 'package:spotted/app/repository/alimento_repository.dart';
import 'package:spotted/app/view/alimento_page/alimentoCadastrar_view.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<Food> foodList = [];
  List<Food> filteredFoodList = [];
  double? minPrice;
  double? maxPrice;
  bool showOnlyOffers = false;
  List<String> selectedTypes = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

  Future<void> _fetchFood() async {
    try {
      final foodList = await FoodRepository().getFood();
      setState(() {
        this.foodList = foodList;
        filteredFoodList = foodList;
      });
    } catch (e) {
      print('Erro ao obter a lista de alimentos: $e');
    }
  }

  void _filterFoodList() {
    setState(() {
      filteredFoodList = foodList.where((food) {
        final meetsPriceCriteria =
            (minPrice == null || food.preco_alimento >= minPrice!) &&
                (maxPrice == null || food.preco_alimento <= maxPrice!);
        final meetsOfferCriteria = showOnlyOffers
            ? food.oferta_alimento.isNotEmpty
            : food.oferta_alimento == null;
        final meetsTypeCriteria =
            selectedTypes.isEmpty || selectedTypes.contains(food.tipo_alimento);
        return meetsPriceCriteria && meetsOfferCriteria && meetsTypeCriteria;
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
              //controller.start();
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
                _filterFoodList();
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
                    value: showOnlyOffers,
                    onChanged: (value) {
                      setState(() {
                        showOnlyOffers = value!;
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
                selected: selectedTypes.contains('Salgado'),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedTypes.add('Salgado');
                    } else {
                      selectedTypes.remove('Salgado');
                    }
                    _filterFoodList();
                  });
                },
              ),
              FilterChip(
                label: Text('Doce'),
                selected: selectedTypes.contains('Doce'),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedTypes.add('Doce');
                    } else {
                      selectedTypes.remove('Doce');
                    }
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
                      height: 450, // TENTANDO AUMENTAR A ALTURA DO QUADRADO LARANJA
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredFoodList[index].titulo_artefato,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Descrição: ${filteredFoodList[index].descricao_artefato}',
                          ),
                          Text(
                            'Tipo: ${filteredFoodList[index].tipo_alimento}',
                          ),
                          Text(
                            'Marca: ${filteredFoodList[index].marca_alimento}',
                          ),
                          Text(
                            'Sabor: ${filteredFoodList[index].sabor_alimento}',
                          ),
                          Text(
                            'Unidade: ${filteredFoodList[index].unidade_alimento}',
                          ),
                          Text(
                            'Preço: ${filteredFoodList[index].preco_alimento.toStringAsFixed(2)}',
                          ),
                          Text(
                            'Oferta: ${filteredFoodList[index].oferta_alimento}',
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
              builder: (context) => alimentoCadastrarPage(),
            ),
          );
        },
      ),
    );
  }
}
