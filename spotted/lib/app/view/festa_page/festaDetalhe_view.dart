import 'package:flutter/material.dart';
import 'festa_view.dart';
import '../../builders/text_builder.dart';
import '../../helpers/button_helper.dart';
import '../../helpers/image_helper.dart';
import '../../model/festa_model.dart';

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
            ImageHelper.buildCarrousel(festa.listaImagens),
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
        ButtonHelper.newButton(
            Colors.blue.shade700, Icons.map, "", festa.localizacaoFesta)
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
          TextBuilder.buildText(festa.descricaoArtefato),
        ],
      ),
    );
  }
}
