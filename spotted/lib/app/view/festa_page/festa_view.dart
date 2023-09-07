import 'package:flutter/material.dart';
import 'package:spotted/app/repository/evento_repository.dart';
import '../../helpers/image_helper.dart';
import 'eventoCadastrar_view.dart';
import 'eventoDetalhe_view.dart';
import '../../controller/alimento_controller.dart';
import '../../model/evento_model.dart';
import '../home_page/home_view.dart';

class EventoPage extends StatefulWidget {
  const EventoPage({Key? key}) : super(key: key);

  @override
  State<EventoPage> createState() => EventoPageState();
}

class EventoPageState extends State<EventoPage> {
  List<Evento> eventoList = [];
  List<Evento> filteredEventoList = [];
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
    _buscarEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventos"),
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
              _buscarEventos();
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
              builder: (context) => EventoCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return _filtros();
  }

  Future<void> _buscarEventos() async {
    try {
      final eventoList = await EventoRepository().getAllEventos();
      print("GetAllEventos concluído com sucesso em EventoPage");
      setState(() {
        this.eventoList = eventoList;
        filteredEventoList = eventoList;
      });
    } catch (e) {
      print('Erro ao obter a lista de eventos em EventoPage: $e');
    }
  }

  void _filterEventoList() {
    setState(() {
      filteredEventoList = filteredEventoList.where((evento) {
        final atendeCriterioCidade =
            cidadeSelecionada == "Selecione uma cidade" ||
                evento.localizacaoEvento?.toLowerCase() ==
                    cidadeSelecionada.toLowerCase();

        final searchTerm = _searchTerm.toLowerCase();
        final titleContainsTerm =
            evento.tituloArtefato.toLowerCase().contains(searchTerm);
        final descriptionContainsTerm =
            evento.descricaoArtefato.toLowerCase().contains(searchTerm);

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
              _searchTerm = value;
              _filterEventoList();
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
            itemCount: filteredEventoList.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EventoDetalhesView(filteredEventoList[index]);
                      },
                    ),
                  );
                },
                child: GridTile(
                  key: ValueKey(filteredEventoList[index].idArtefato),
                  footer: GridTileBar(
                    backgroundColor: const Color.fromARGB(137, 107, 98, 98),
                    title: Text(
                      filteredEventoList[index].tituloArtefato,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "R\$ ${filteredEventoList[index].localizacaoEvento}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: ImageHelper.buildCarrousel(
                      filteredEventoList[index].listaImagens),
                ),
              );
            }),
      )
    ]);
  }
}
