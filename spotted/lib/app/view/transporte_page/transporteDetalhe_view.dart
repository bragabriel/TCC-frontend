import 'package:flutter/material.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          listaDeImagens![0].url,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 50,
                            left: 20,
                            right: 20,
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TransportePage(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.arrow_back_ios_new),
                              ),
                            ],
                          ),
                        ),
                      ),
                     Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    top: 30, right: 30, left: 30),
                                height: 110,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(.2),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transporte.tituloArtefato,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.none,
                                            ),
                                            softWrap: true,
                                          ),
                                          Text(
                                           transporte.cidadeTransporte as String,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              decoration: TextDecoration.none,
                                            ),
                                            softWrap: true,
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ],
                                )))
                      ],
                    ),
                  ),
                )),
             
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 5, left: 20, right: 30),
                constraints: const BoxConstraints(maxHeight: double.infinity), // Set valid constraints
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Descrição",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        transporte.descricaoArtefato,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Sobre o condutor: ",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        transporte.informacoesCondutorTransporte.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Veículo",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        transporte.informacoesVeiculoTransporte.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Assentos totais: ",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        transporte.qtdAssentosTotalTransporte.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Assentos preenchidos: ",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        transporte.qtdAssentosPreenchidosTransporte.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
