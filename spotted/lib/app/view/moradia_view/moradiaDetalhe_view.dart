import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/artefato_model.dart';
import '../../model/moradia_model.dart';
import '../home_page/home_view.dart';
import 'moradia_view.dart';

class MoradiaDetalheView extends StatefulWidget {
  @override
  State<MoradiaDetalheView> createState() => MoradiaDetalheState();

  final Moradia filteredMoradiaList;
  const MoradiaDetalheView(this.filteredMoradiaList, {super.key});
}

class MoradiaDetalheState extends State<MoradiaDetalheView> {
  @override
  Widget build(BuildContext context) {
    Moradia moradia = widget.filteredMoradiaList;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            _buildImagens(moradia.listaImagens),
            DetalhesMoradia(moradia: moradia),
            BotaoMoradia(moradia: moradia),
          ],
        ),
      ),
    );
  }
}

class BotaoMoradia extends StatelessWidget {
  final Moradia moradia;

  BotaoMoradia({required this.moradia});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _newButton(
            Colors.blue,
            Icons.message,
            'https://api.whatsapp.com/send/?phone=55',
            "19999138267") // moradia.contato)
      ],
    );
  }
}

class DetalhesMoradia extends StatelessWidget {
  final Moradia moradia;

  DetalhesMoradia({required this.moradia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        children: [
          Text(
            "${moradia.tituloArtefato} - ${moradia.cidadeMoradia} \n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          Text(
            "${moradia.descricaoArtefato} \n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Text(
            "${moradia.vagaGaragemMoradia} \n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Text(
            "R\$ ${moradia.precoAluguelTotalMoradia?.toStringAsFixed(2) ?? '0.00'} \n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

void _openURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Não foi possível abrir $url';
  }
}

Column _newButton(Color color, IconData icon, String textBase, String dado) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      IconButton(
        icon: Icon(icon, color: color, size: 50),
        onPressed: () => _openURL(textBase + dado),
      ),
    ],
  );
}

Widget _buildImagens(List<Imagem>? listaDeImagens) {
  if (!listaDeImagens!.isEmpty) {
    final imageAspectRatio = 2 / 3;
    return Scaffold(
      body: AspectRatio(
        aspectRatio: imageAspectRatio,
        child: Container(
          width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              enlargeCenterPage: true,
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
        ),
      ),
    );
  } else {
    return Center(
      child: Image.asset('assets/images/imagem.png'),
    );
  }
}
