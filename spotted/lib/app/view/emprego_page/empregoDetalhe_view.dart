import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'emprego_view.dart';
import '../../model/artefato_model.dart';
import '../../model/emprego_model.dart';

class EmpregoDetalheView extends StatefulWidget {
  @override
  State<EmpregoDetalheView> createState() => EmpregoDetalheState();

  final Emprego filteredEmpregoList;
  const EmpregoDetalheView(this.filteredEmpregoList, {super.key});
}

class EmpregoDetalheState extends State<EmpregoDetalheView> {
  @override
  Widget build(BuildContext context) {
    Emprego emprego = widget.filteredEmpregoList;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmpregoPage()),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            _buildCarrousel(emprego.listaImagens),
            DetalhesEmprego(emprego: emprego),
            BotaoEmprego(emprego: emprego),
          ],
        ),
      ),
    );
  }
}

class BotaoEmprego extends StatelessWidget {
  final Emprego emprego;

  BotaoEmprego({required this.emprego});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _newButton(Colors.blue.shade700, Icons.web, "", emprego.linkVagaEmprego)
      ],
    );
  }
}

class DetalhesEmprego extends StatelessWidget {
  final Emprego emprego;

  DetalhesEmprego({required this.emprego});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        children: [
          Text(
            "${emprego.tituloArtefato} - ${emprego.localizacaoEmprego} \n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          _buildText(emprego.descricaoArtefato),
          _buildText("Nível: ${emprego.experienciaEmprego}"),
          _buildText("Requisitos: ${emprego.requisitosEmprego}"),
          _buildText("Modalidade: ${emprego.presencialEmprego}"),
          _buildText("Tipo: ${emprego.tipoVagaEmprego}"),
          Text(
            "R\$ ${emprego.salarioEmprego?.toStringAsFixed(2) ?? '0.00'}",
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

Widget _buildCarrousel(List<Imagem>? listaDeImagens) {
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
