import 'package:flutter/material.dart';
import 'package:spotted/app/constants/constants.dart';
import 'package:spotted/app/helpers/button_helper.dart';
import 'package:spotted/app/helpers/image_helper.dart';
import '../../model/objeto_model.dart';
import 'objeto_view.dart';

class ObjetoDetalheView extends StatefulWidget {
  @override
  State<ObjetoDetalheView> createState() => _DetailsState();

  final Objeto filteredFoodList;
  const ObjetoDetalheView(this.filteredFoodList, {super.key});
}

class _DetailsState extends State<ObjetoDetalheView> {
  @override
  Widget build(BuildContext context) {
    Objeto objeto = widget.filteredFoodList;

    var listaDeImagens = objeto.listaImagens;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ObjetoPage()),
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
                              objeto.tituloArtefato,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.none,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              objeto.localizacaoAchadoObjeto as String,
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
                        objeto.descricaoArtefato,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Localização achado",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        objeto.localizacaoAchadoObjeto.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Localização atual",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        objeto.localizacaoAtualObjeto.toString(),
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
