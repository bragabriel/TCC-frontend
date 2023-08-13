import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/festa_model.dart';
import '../../model/artefato_model.dart';
import 'festa_view.dart';

class FestaDetalhesView extends StatefulWidget {
  @override
  State<FestaDetalhesView> createState() => EmpregoDetalheState();

  final Festa filteredFestaList;
  const FestaDetalhesView(this.filteredFestaList, {super.key});
}

class EmpregoDetalheState extends State<FestaDetalhesView> {
  @override
  Widget build(BuildContext context) {
    Festa festa = widget.filteredFestaList;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FestaPage()),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            _buildImagens(festa.listaImagens),
            DetalhesFesta(festa: festa),
            BotaoFesta(festa: festa),
          ],
        ),
      ),
    );
  }
}

class BotaoFesta extends StatelessWidget {
  final Festa festa;

  BotaoFesta({required this.festa});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _newButton(Colors.blue.shade700, Icons.map, "", festa.localizacaoFesta)
      ],
    );
  }
}

class DetalhesFesta extends StatelessWidget {
  final Festa festa;

  DetalhesFesta({required this.festa});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        children: [
          Text(
            "${festa.tituloArtefato} - ${festa.localizacaoFesta} \n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          _buildText(festa.descricaoArtefato),
          // Add more details here
        ],
      ),
    );
  }
}

void _openURL(String? url) async {
  if (await canLaunch(url!)) {
    await launch(url);
  } else {
    throw 'Não foi possível abrir $url';
  }
}

Column _newButton(Color color, IconData icon, String? textBase, String? dado) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      IconButton(
        icon: Icon(icon, color: color, size: 50),
        onPressed: () => _openURL(textBase! + dado!),
      ),
      SizedBox(height: 20),
    ],
  );
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

Text _buildText(String? text) {
  return Text(
    "$text \n",
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  );
}
