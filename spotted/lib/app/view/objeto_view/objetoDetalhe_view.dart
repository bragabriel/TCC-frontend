import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/artefato_model.dart';
import '../../model/objeto_model.dart';
import 'objeto_view.dart';


class ObjetoDetalheView extends StatefulWidget {
  @override
  State<ObjetoDetalheView> createState() => ObjetoDetalheState();

  final Objeto filteredObjetoList;
  const ObjetoDetalheView(this.filteredObjetoList, {super.key});
}

class ObjetoDetalheState extends State<ObjetoDetalheView> {
  @override
  Widget build(BuildContext context) {
    Objeto objeto = widget.filteredObjetoList; 
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ObjetoPage()),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            _buildImagens(objeto.listaImagens),
            DetalhesObjeto(objeto: objeto,), 
            BotaoObjeto(objeto: objeto), 
          ],
        ),
      ),
    );
  }
}

class BotaoObjeto extends StatelessWidget {
  final Objeto objeto; 

  BotaoObjeto({required this.objeto}); 

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _newButton(
            Colors.blue.shade700,
            Icons.web ,"",
            objeto.localizacaoAchadoObjeto)
      ],
    );
  }
}

class DetalhesObjeto extends StatelessWidget {
  final Objeto objeto; 

  DetalhesObjeto({required this.objeto}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        children: [
          Text(
            "${objeto.tituloArtefato} - ${objeto.localizacaoAchadoObjeto} \n", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          _buildText(objeto.descricaoArtefato), 
          _buildText("Encontrado em: ${objeto.localizacaoAchadoObjeto}"),
          _buildText("Agora está em: ${objeto.localizacaoAchadoObjeto}"),
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

Text _buildText(String? text) {
  return Text(
    "$text \n",
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  );
}

