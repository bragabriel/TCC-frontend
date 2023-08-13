import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/model/alimento_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/artefato_model.dart';
import 'alimento_view.dart';

class AlimentoDetalheView extends StatefulWidget {
  @override
  State<AlimentoDetalheView> createState() => AlimentoDetalheState();

  final Alimento filteredFoodList;
  const AlimentoDetalheView(this.filteredFoodList, {super.key});
}

class AlimentoDetalheState extends State<AlimentoDetalheView> {
  @override
  Widget build(BuildContext context) {
    Alimento alimento = widget.filteredFoodList;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlimentoPage()),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            _buildImagens(alimento.listaImagens),
            DetalhesAlimento(alimento: alimento),
            BotaoAlimento(alimento: alimento),
          ],
        ),
      ),
    );
  }
}

class BotaoAlimento extends StatelessWidget {
  final Alimento alimento;

  BotaoAlimento({required this.alimento});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _newButton(
            Colors.blue,
            Icons.message,
            'https://api.whatsapp.com/send/?phone=55',
            "19999138267") //alimento.contato)
      ],
    );
  }
}

class DetalhesAlimento extends StatelessWidget {
  final Alimento alimento;

  DetalhesAlimento({required this.alimento});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        children: [
          Text(
            "${alimento.tituloArtefato} - ${alimento.saborAlimento} \n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          _buildText(alimento.descricaoArtefato),
          _buildText(alimento.saborAlimento),
          _buildText(alimento.unidadeAlimento),
          _buildText(alimento.descricaoArtefato),
          Text(
            "R\$ ${alimento.precoAlimento?.toStringAsFixed(2) ?? '0.00'}",
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
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
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
