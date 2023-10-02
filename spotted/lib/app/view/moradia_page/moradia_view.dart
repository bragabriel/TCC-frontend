import 'package:flutter/material.dart';
import 'package:spotted/app/repository/moradia_repository.dart';
import 'package:spotted/app/model/moradia_model.dart';
import 'package:spotted/app/view/moradia_page/moradiaCadastrar_view.dart';
import 'package:spotted/app/view/moradia_page/moradiaDetalhe_view.dart';
import '../../helpers/image_helper.dart';
import '../../controller/moradia_controller.dart';
import '../home_page/home_view.dart';

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
  String _searchTerm = '';
  String cidadeSelecionada = 'Selecione uma cidade';
  String estadoSelecionado = 'Selecione um estado';

  final _searchController = TextEditingController();
  final controller = MoradiaController();

  @override
  void initState() {
    super.initState();
    controller.start();
    _buscarMoradia();
  }

  Future<void> _buscarMoradia() async {
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

  void _filtrareListarMoradia() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moradia"),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.start();
              _buscarMoradia();
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
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MoradiaCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  _success() {
    return _filtros();
  }

  _error() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Ops, algo de errado aconteceu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.start();
            },
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  _loading() {
    return const Center(child: CircularProgressIndicator());
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

  Column _filtros() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchTerm = value;
                _filtrareListarMoradia();
              });
            },
            decoration: const InputDecoration(
              labelText: 'Pesquisar',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _newButton(minPrice, "Min preço", (value) => minPrice = value),
            _newButton(maxPrice, "Max preço", (value) => maxPrice = value),
            _newButton(qtdMoradoresFilter, "Max moradores",
                (value) => qtdMoradoresFilter = value),
          ],
        ),
        const SizedBox(height: 10),
        _buildDropdownButtonFormField(
          cidadeSelecionada,
          "Cidade",
          _obterListaDeCidades(),
          (novaCidade) {
            setState(() {
              cidadeSelecionada = novaCidade!;
              _filtrareListarMoradia();
            });
          },
        ),
        _buildDropdownButtonFormField(
          estadoSelecionado,
          "Estado",
          _obterListaDeEstados(),
          (novoEstado) {
            setState(() {
              estadoSelecionado = novoEstado!;
              _filtrareListarMoradia();
            });
          },
        ),
        const SizedBox(height: 10),
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
                  child: Image.network(
                      filteredMoradiaList[index].imagem.url),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildDropdownButtonFormField(String value, String labelText,
      List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Column _newButton(
    dynamic filter,
    String placeholder,
    void Function(dynamic) updateFilter,
  ) {
    return Column(
      children: [
        const SizedBox(height: 4),
        SizedBox(
          width: 100,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                filter = value.isEmpty ? null : int.parse(value);
                _filtrareListarMoradia();
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: placeholder,
            ),
          ),
        ),
      ],
    );
  }

  List<String> _obterListaDeCidades() {
    final cidades = moradiaList
        .map((moradia) => moradia.cidadeMoradia)
        .where((cidade) => cidade != null)
        .map((cidade) => cidade!)
        .toSet()
        .toList();

    cidades.insert(0, "Selecione uma cidade");
    return cidades;
  }

  List<String> _obterListaDeEstados() {
    final estados = moradiaList
        .map((moradia) => moradia.estadoMoradia)
        .where((estado) => estado != null)
        .map((estado) => estado!)
        .toSet()
        .toList();

    estados.insert(0, "Selecione um estado");
    return estados;
  }
}
