import 'package:flutter/material.dart';
import 'package:spotted/app/constants/constants.dart';
import 'package:spotted/app/helpers/image_helper.dart';
import 'objetoCadastrar_view.dart';
import '../../controller/objeto_controller.dart';
import '../../model/objeto_model.dart';
import '../../repository/objeto_repository.dart';
import '../home_page/home_view.dart';
import 'objetoDetalhe_view.dart';

class ObjetoPage extends StatefulWidget {
  const ObjetoPage({Key? key}) : super(key: key);

  @override
  State<ObjetoPage> createState() => ObjetoPageState();
}

class ObjetoPageState extends State<ObjetoPage> {
  List<Objeto> objetoList = [];
  List<Objeto> filteredobjetoList = [];
  String _searchTerm = '';
  String _searchLocalizacao = '';

  final _searchController = TextEditingController();
  final controller = ObjetoController();

  _success() {
    return _body();
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

  @override
  void initState() {
    super.initState();
    controller.start();
    _buscarObjeto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Objetos perdidos"),
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
              _buscarObjeto();
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
              builder: (context) => const ObjetoCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return _filtros();
  }

  Future<void> _buscarObjeto() async {
    try {
      final objetoList = await ObjetoRepository().getAllObjetos();
      setState(() {
        this.objetoList = objetoList;
        filteredobjetoList = objetoList;
      });
    } catch (e) {
      print('Erro ao obter a lista de objetos: $e');
    }
  }

  void _filterobjetoList() {
    setState(() {
      filteredobjetoList = objetoList.where((objeto) {
        final searchTerm = _searchTerm.toLowerCase();
        final titleContainsTerm =
            objeto.tituloArtefato.toLowerCase().contains(searchTerm);
        final descriptionContainsTerm =
            objeto.descricaoArtefato.toLowerCase().contains(searchTerm);
        final achadoContainsTerm = objeto.localizacaoAchadoObjeto!
            .toLowerCase()
            .contains(_searchLocalizacao);

        return achadoContainsTerm &&
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
              _searchTerm = value;
              _filterobjetoList();
            });
          },
          decoration: const InputDecoration(
            labelText: 'Pesquisar',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            setState(() {
              // Update the localização search term
              _searchLocalizacao = value.toLowerCase();
              _filterobjetoList();
            });
          },
          decoration: const InputDecoration(
            labelText: 'Localização que Perdeu o Objeto',
            prefixIcon: Icon(Icons.location_on),
          ),
        ),
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
          itemCount: filteredobjetoList.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ObjetoDetalheView(filteredobjetoList[index]);
                    },
                  ),
                );
              },
              child: GridTile(
                key: ValueKey(filteredobjetoList[index].idArtefato),
                footer: GridTileBar(
                  backgroundColor: cardColor,
                  title: Text(
                    filteredobjetoList[index].tituloArtefato,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    filteredobjetoList[index].localizacaoAchadoObjeto!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                child: ImageHelper.loadImage(
                  filteredobjetoList[index].listaImagens,
                ),
              ),
            );
          },
        ),
      )
    ]);
  }
}
