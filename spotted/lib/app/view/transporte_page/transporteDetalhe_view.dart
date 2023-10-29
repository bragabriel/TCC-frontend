import 'package:flutter/material.dart';
import 'package:spotted/app/constants/constants.dart';
import 'package:spotted/app/helpers/image_helper.dart';
import 'package:spotted/app/view/transporte_page/transporte_view.dart';
import '../../model/transporte_model.dart';

class TransporteDetalheView extends StatefulWidget {
  @override
  State<TransporteDetalheView> createState() => _DetailsState();

  final Transporte filteredFoodList;
  const TransporteDetalheView(this.filteredFoodList, {super.key});
}

class _DetailsState extends State<TransporteDetalheView> {
  @override
  Widget build(BuildContext context) {
    Transporte transporte = widget.filteredFoodList;

    var listaDeImagens = transporte.listaImagens;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TransportePage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Positioned.fill(
                        child: ImageHelper.loadImage(listaDeImagens),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 5,
                          right: 15,
                          left: 15,
                        ),
                        height: 100,
                        decoration: BoxDecoration(
                          color: cardColor,
                        ),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transporte.tituloArtefato,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.none,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              transporte.cidadeTransporte as String,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Descrição",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        transporte.descricaoArtefato,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sobre o condutor",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        transporte.informacoesCondutorTransporte.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Veículo",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        transporte.informacoesVeiculoTransporte.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Assentos totais",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        transporte.qtdAssentosTotalTransporte.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Assentos preenchidos",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        transporte.qtdAssentosPreenchidosTransporte.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
