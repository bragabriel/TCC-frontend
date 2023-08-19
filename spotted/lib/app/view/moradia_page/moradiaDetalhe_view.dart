import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../builders/text_builder.dart';
import '../../helpers/button_helper.dart';
import '../../helpers/image_helper.dart';
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
            ImageHelper.buildCarrousel(moradia.listaImagens),
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
        ButtonHelper.newButton(
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
            TextBuilder.buildText(moradia.descricaoArtefato),
            TextBuilder.buildText(moradia.vagaGaragemMoradia),
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
