import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/model/objeto_model.dart';
import 'package:spotted/app/repository/objeto_repository.dart';
import '../../model/artefato_model.dart';
import '../home_page/home_view.dart';
import 'objetoCadastrar_view.dart';
import 'objetoDetalhe_view.dart';

class ObjetoPage extends StatefulWidget {
  const ObjetoPage({Key? key}) : super(key: key);

  @override
  _ObjetoPageState createState() => _ObjetoPageState();
}

class _ObjetoPageState extends State<ObjetoPage> {
  List<Objeto> listaDeObjetos = [];
  List<Objeto> listaFiltradaDeObjetos = [];
  String localizacaoAtual = 'Selecione localização atual';
  String localizacaoEncontrada = 'Selecione localização encontrada';
  String? presencialSelecionado;
  double? salarioMinimo;
  double? salarioMaximo;

  @override
  void initState() {
    super.initState();
    _carregarObjetos();
  }

  Future<void> _carregarObjetos() async {
    try {
      final listaDeObjetos = await ObjetoRepository().getAllObjetos();
      setState(() {
        this.listaDeObjetos = listaDeObjetos;
        listaFiltradaDeObjetos = listaDeObjetos;
      });
    } catch (e) {
      print('Erro ao obter a lista de objetos: $e');
    }
  }

  List<String> _obterListaDeLocaisEncontrados() {
    final objetos = listaDeObjetos
        .map((objeto) => objeto.localizacaoAchadoObjeto)
        .where((objeto) => objeto != null)
        .map((objeto) => objeto!)
        .toSet()
        .toList();

    objetos.insert(0, "Selecione local encontrado");

    return objetos;
  }

  List<String> _obterListaDeLocaisAtual() {
    final objetos = listaDeObjetos
        .map((objeto) => objeto.localizacaoAtualObjeto)
        .where((objeto) => objeto != null)
        .map((objeto) => objeto!)
        .toSet()
        .toList();

    objetos.insert(0, "Selecione localização do objeto encontrado");

    return objetos;
  }

  void _filtrarlistaDeObjetos() {
    setState(() {
      listaFiltradaDeObjetos = listaDeObjetos.where((objeto) {
        final atendelocalizacaoAtual =
            localizacaoAtual == "Selecione localização atual" ||
                objeto.localizacaoAtualObjeto?.toLowerCase() ==
                    localizacaoAtual.toLowerCase();

        final atendelocalizacaoAchado =
            localizacaoEncontrada == "Selecione localização encontrada" ||
                objeto.localizacaoAchadoObjeto?.toLowerCase() ==
                    localizacaoEncontrada.toLowerCase();

        return atendelocalizacaoAtual && atendelocalizacaoAchado;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Objetos"),
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
              _carregarObjetos();
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: _construirFiltrosELista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ObjetoCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Widget _construirFiltrosELista() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (valor) {
              setState(() {});
            },
            decoration: InputDecoration(
              labelText: 'Pesquisar',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: localizacaoAtual,
            onChanged: (novaCidade) {
              setState(() {
                localizacaoAtual = novaCidade!;
                _filtrarlistaDeObjetos();
              });
            },
            items: _obterListaDeLocaisEncontrados()
                .map<DropdownMenuItem<String>>((cidade) {
              return DropdownMenuItem<String>(
                value: cidade,
                child: Text(cidade),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Locais encontrados',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: localizacaoEncontrada,
            onChanged: (novaEmpresa) {
              setState(() {
                localizacaoEncontrada = novaEmpresa!;
                _filtrarlistaDeObjetos();
              });
            },
            items: _obterListaDeLocaisAtual()
                .map<DropdownMenuItem<String>>((empresa) {
              return DropdownMenuItem<String>(
                value: empresa,
                child: Text(empresa),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Localização atual',
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
            itemCount: listaFiltradaDeObjetos.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ObjetoDetalheView(
                              listaFiltradaDeObjetos[index]);
                        },
                      ),
                    );
                  },
                  child: GridTile(
                    key: ValueKey(listaFiltradaDeObjetos[index].idArtefato),
                    footer: GridTileBar(
                      backgroundColor: const Color.fromARGB(137, 107, 98, 98),
                      title: Text(
                        listaFiltradaDeObjetos[index].tituloArtefato,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        listaFiltradaDeObjetos[index].localizacaoAchadoObjeto ??
                            "Local não disponível",
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    child: _buildImagens(listaDeObjetos[index].listaImagens),
                  ));
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildImagens(List<Imagem>? listaDeImagens) {
  if (!listaDeImagens!.isEmpty) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = 16;
        final screenHeight = 9;
        final imageAspectRatio = screenWidth / screenHeight;
        return Container(
          width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: imageAspectRatio,
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
        );
      },
    );
  } else {
    return Center(
      child: Image.asset('assets/images/imagem.png'),
    );
  }
}
