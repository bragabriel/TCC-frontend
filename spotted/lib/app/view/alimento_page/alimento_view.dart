import 'package:flutter/material.dart';
import 'package:spotted/app/repository/alimento_repository.dart';
import 'package:spotted/app/model/alimento_model.dart';

import 'alimentoCadastrar_view.dart';

class AlimentoPage extends StatefulWidget {
  const AlimentoPage({Key? key}) : super(key: key);

  @override
  _AlimentoPageState createState() => _AlimentoPageState();
}

class _AlimentoPageState extends State<AlimentoPage> {
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
      final foodList = await AlimentoRepository().getAllAlimentos();
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
      body: _filtros(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlimentoCadastrarView(),
            ),
          );
          _botaoNovo(
              Colors.green,
              Icons.message,
              'https://api.whatsapp.com/send/?phone=55',
              "filteredFoodList[].id_artefato");
          _botaoNovo(Colors.blueAccent, Icons.near_me,
              'https://www.google.com/maps/search/', "localizao");
          _botaoNovo(Colors.black, Icons.link, '', "linkvaga");
        },
      ),
    );
  }

  List<Container> _titleSection() {
    return List.generate(
      filteredFoodList.length,
      (index) =>
          /*2*/
          Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  Text(
                    "${filteredFoodList[index].tituloArtefato} – ${filteredFoodList[index].saborAlimento} \n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                  Text(
                    "Descrição: ${filteredFoodList[index].descricaoArtefato} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Tipo: ${filteredFoodList[index].tipoAlimento} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Marca: ${filteredFoodList[index].descricaoArtefato} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Sabor: ${filteredFoodList[index].saborAlimento} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Unidades: ${filteredFoodList[index].unidadeAlimento} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Preço: ${filteredFoodList[index].tipoAlimento} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Oferta: Preço: R\$ ${filteredFoodList[index].precoAlimento?.toStringAsFixed(2) ?? '0.00'} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  )
                ],
              )),
    );
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

  Column _filtros() {
    return Column(children: [
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
        child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: filteredFoodList.length,
            itemBuilder: (BuildContext ctx, index) {
              return GridTile(
                key: ValueKey(filteredFoodList[index].idArtefato),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    filteredFoodList[index].tituloArtefato,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(filteredFoodList[index].tipoArtefato),
                ),
                // child: Image.network(
                //   _jobs[index]['imagem'],
                //   fit: BoxFit.cover,
                // ),
                child: Image.asset(
                  'assets/images/jobs.jpg',
                  fit: BoxFit.cover,
                ),
              );
            }),
      )
    ]);
  }

  Column _botaoNovo(Color color, IconData icon, String textBase, String dado) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(icon, color: color, size: 50),
          onPressed: () => abrirUrl(textBase + dado),
          alignment: Alignment.topCenter,
        ),
      ],
    );
  }
}

void abrirUrl(String url) async {
 /*
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw '[LOG] NAO DEU PARA RODAR ESSA PORRA AQUI: $url';
  } 
  */
}
