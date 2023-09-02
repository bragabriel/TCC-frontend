import 'package:flutter/material.dart';
import 'package:spotted/app/view/transporte_page/transporte_view.dart';
import '../../builders/text_builder.dart';
import '../../helpers/button_helper.dart';
import '../../helpers/image_helper.dart';
import '../../model/transporte_model.dart';

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
            ImageHelper.buildCarrousel(transporte.listaImagens),
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
        ButtonHelper.newButton(Colors.blue.shade700, Icons.map_sharp,
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
          TextBuilder.buildText(transporte.descricaoArtefato),
          TextBuilder.buildText(
              "Informações condutor: ${transporte.informacoesCondutorTransporte}"),
          TextBuilder.buildText(
              "Informações veículo: ${transporte.informacoesVeiculoTransporte}"),
          TextBuilder.buildText("Periodo: ${transporte.periodoTransporte}"),
          TextBuilder.buildText(
              "Acentos disponíveis: ${transporte.qtdAssentosPreenchidosTransporte}"),
          TextBuilder.buildText(
              "Acentos totais: ${transporte.qtdAssentosTotalTransporte}"),
        ],
      ),
    );
  }
}

