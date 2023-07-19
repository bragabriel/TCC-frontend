import 'package:flutter/material.dart';
import 'package:spotted/app/repository/alimento_repository.dart';
import 'package:spotted/app/view/alimento_page/alimentoCadastrar_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AlimentoView extends StatefulWidget {
  const AlimentoView({Key? key}) : super(key: key);

  @override
  _AlimentoViewState createState() => _AlimentoViewState();
}

List<dynamic> foodList = [];
List<dynamic> filteredFoodList = [];
double? minPrice;
double? maxPrice;
bool showOnlyOffers = false;
List<String> selectedTypes = [];

TextEditingController _searchController = TextEditingController();

class _AlimentoViewState extends State<AlimentoView> {
  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

 void _fetchFood() async {
    try {
      final finalFoodList = await AlimentoRepository().getFood();
      setState(() {
        foodList = finalFoodList;
        filteredFoodList = finalFoodList;
      });
    } catch (e) {
      print('Erro ao obter a lista de alimentos: $e');
    }
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
      body: _filtros(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => alimentoCadastrarPage(),
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

  ///////////////////////////////
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
/////////////////////

//   Widget buttonSection = Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
// ,
//     ],
//   );

//////////////////

  Column _filtros() {
    return Column(
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
                  key: ValueKey(filteredFoodList[index].id_artefato),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      filteredFoodList[index].titulo_artefato,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(filteredFoodList[index].tipo_alimento),
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
      ],
    );
  }

//////////

  void abrirUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw '[LOG] NAO DEU PARA RODAR ESSA PORRA AQUI: $url';
    }
  }

////////////////////////////////////////
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
                    "${filteredFoodList[index].titulo_artefato} – ${filteredFoodList[index].sabor} \n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                  Text(
                    "Descrição: ${filteredFoodList[index].descricao_artefato} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Tipo: ${filteredFoodList[index].tipo_alimento} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Marca: ${filteredFoodList[index].descricao_artefato} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Sabor: ${filteredFoodList[index].sabor_artefato} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Unidades: ${filteredFoodList[index].unidade_alimento} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Preço: ${filteredFoodList[index].tipo_alimento} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Oferta: ${filteredFoodList[index].oferta_alimento} \n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  )
                ],
              )),
    );
  }

/////////////////////////
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
