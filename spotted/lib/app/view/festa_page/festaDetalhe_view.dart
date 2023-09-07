import 'package:flutter/material.dart';
import 'evento_view.dart';
import '../../builders/text_builder.dart';
import '../../helpers/button_helper.dart';
import '../../helpers/image_helper.dart';
import '../../model/evento_model.dart';

class EventoDetalhesView extends StatefulWidget {
  @override
  State<EventoDetalhesView> createState() => EmpregoDetalheState();

  final Evento filteredEventoList;
  const EventoDetalhesView(this.filteredEventoList, {super.key});
}

class EmpregoDetalheState extends State<EventoDetalhesView> {
  @override
  Widget build(BuildContext context) {
    Evento Evento = widget.filteredEventoList;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventoPage()),
              );
            },
          ),
        ),
        body: ListView(
          children: [
            ImageHelper.buildCarrousel(evento.listaImagens),
            DetalhesEvento(evento: evento),
            BotaoEvento(evento: evento),
          ],
        ),
      ),
    );
  }
}

class BotaoEvento extends StatelessWidget {
  final evento evento;

  BotaoEvento({required this.evento});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonHelper.newButton(
            Colors.blue.shade700, Icons.map, "", evento.localizacaoEvento)
      ],
    );
  }
}

class DetalhesEvento extends StatelessWidget {
  final Evento Evento;

  DetalhesEvento({required this.evento});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        children: [
          Text(
            "${evento.tituloArtefato} - ${evento.localizacaoEvento} \n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          TextBuilder.buildText(evento.descricaoArtefato),
        ],
      ),
    );
  }
}
