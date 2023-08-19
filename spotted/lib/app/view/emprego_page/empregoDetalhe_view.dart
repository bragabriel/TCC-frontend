import 'package:flutter/material.dart';
import 'emprego_view.dart';
import '../../builders/text_builder.dart';
import '../../helpers/button_helper.dart';
import '../../helpers/image_helper.dart';
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
            ImageHelper.buildCarrousel(emprego.listaImagens),
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
        ButtonHelper.newButton(
            Colors.blue.shade700, Icons.web, "", emprego.linkVagaEmprego)
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
          TextBuilder.buildText(emprego.descricaoArtefato),
          TextBuilder.buildText("Nível: ${emprego.experienciaEmprego}"),
          TextBuilder.buildText("Requisitos: ${emprego.requisitosEmprego}"),
          TextBuilder.buildText("Modalidade: ${emprego.presencialEmprego}"),
          TextBuilder.buildText("Tipo: ${emprego.tipoVagaEmprego}"),
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
