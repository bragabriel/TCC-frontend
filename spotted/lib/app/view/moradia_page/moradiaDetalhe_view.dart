import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/artefato_model.dart';
import '../../model/moradia_model.dart';
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
                MaterialPageRoute(builder: (context) => MoradiaPage()),
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
    return SingleChildScrollView(
      child: Container(
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
            _buildText(moradia.descricaoArtefato),
            _buildText(moradia.vagaGaragemMoradia),
            Text(
              "R\$ ${moradia.precoAluguelTotalMoradia?.toStringAsFixed(2) ?? '0.00'} \n",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
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
      SizedBox(
          height:
              20), // Espaço adicionado abaixo do botão (pode ajustar o valor conforme necessário)
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
