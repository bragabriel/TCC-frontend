import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../builders/text_builder.dart';
import '../../helpers/button_helper.dart';
import '../../helpers/image_helper.dart';
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
            ImageHelper.buildCarrousel(objeto.listaImagens),
            DetalhesObjeto(
              objeto: objeto,
            ),
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
        ButtonHelper.newButton(
            Colors.blue.shade700, Icons.web, "", objeto.localizacaoAchadoObjeto)
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
          TextBuilder.buildText(objeto.descricaoArtefato),
          TextBuilder.buildText(
              "Encontrado em: ${objeto.localizacaoAchadoObjeto}"),
          TextBuilder.buildText(
              "Agora está em: ${objeto.localizacaoAchadoObjeto}"),
        ],
      ),
    );
  }
}
