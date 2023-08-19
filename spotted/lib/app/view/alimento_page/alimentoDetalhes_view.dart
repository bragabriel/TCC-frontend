import 'package:flutter/material.dart';
import 'package:spotted/app/model/alimento_model.dart';
import 'alimento_view.dart';
import '../../builders/text_builder.dart';
import '../../helpers/button_helper.dart';
import '../../helpers/imageCarrousel_helper.dart';

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
            ImageHelper.buildCarrousel(alimento.listaImagens),
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
        ButtonHelper.newButton(Colors.blue, Icons.message,
            'https://api.whatsapp.com/send/?phone=55', alimento.telefoneUsuario)
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
          TextHelper.buildText(alimento.descricaoArtefato),
          TextHelper.buildText(alimento.saborAlimento),
          TextHelper.buildText(alimento.unidadeAlimento),
          TextHelper.buildText(alimento.descricaoArtefato),
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
