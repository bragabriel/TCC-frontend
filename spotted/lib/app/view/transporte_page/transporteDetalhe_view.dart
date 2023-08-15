import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/view/transporte_page/transporte_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/transporte_model.dart';
import '../../model/artefato_model.dart';

class TransporteDetalheView extends StatefulWidget {
  @override
  State<TransporteDetalheView> createState() => TransporteDetalheState();

  final Transporte filteredTransporteList;
  const TransporteDetalheView(this.filteredTransporteList, {super.key});
}

class TransporteDetalheState extends State<TransporteDetalheView> {
  @override
  Widget build(BuildContext context) {
    Transporte transporte = widget.filteredTransporteList;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransportePage()),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            _buildImagens(transporte.listaImagens),
            DetalhesTransporte(transporte: transporte),
            BotaoTransporte(transporte: transporte),
          ],
        ),
      ),
    );
  }
}

class BotaoTransporte extends StatelessWidget {
  final Transporte transporte;

  BotaoTransporte({required this.transporte});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _newButton(Colors.blue.shade700, Icons.map_sharp,
            "https://www.google.com/maps/place/", transporte.cidadeTransporte)
      ],
    );
  }
}

class DetalhesTransporte extends StatelessWidget {
  final Transporte transporte;

  DetalhesTransporte({required this.transporte});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        children: [
          Text(
            "${transporte.tituloArtefato} - ${transporte.cidadeTransporte} \n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          _buildText(transporte.descricaoArtefato),
          _buildText(
              "Informações condutor: ${transporte.informacoesCondutorTransporte}"),
          _buildText(
              "Informações veículo: ${transporte.informacoesVeiculoTransporte}"),
          _buildText("Periodo: ${transporte.periodoTransporte}"),
          _buildText(
              "Acentos disponíveis: ${transporte.qtdAssentosPreenchidosTransporte}"),
          _buildText(
              "Acentos totais: ${transporte.qtdAssentosTotalTransporte}"),
          // Text(
          //   "R\$ ${transporte.valor?.toStringAsFixed(2) ?? '0.00'}",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 18,
          //   ),
          // ),
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
