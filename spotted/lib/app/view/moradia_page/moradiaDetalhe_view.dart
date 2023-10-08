import 'package:flutter/material.dart';
import 'package:spotted/app/helpers/button_helper.dart';
import 'package:spotted/app/helpers/image_helper.dart';
import 'package:spotted/app/view/moradia_page/moradia_view.dart';
import '../../model/moradia_model.dart';

class MoradiaDetalheView extends StatefulWidget {
  @override
  State<MoradiaDetalheView> createState() => _DetailsState();

  final Moradia filteredFoodList;
  const MoradiaDetalheView(this.filteredFoodList, {super.key});
}

class _DetailsState extends State<MoradiaDetalheView> {
  @override
  Widget build(BuildContext context) {
    Moradia moradia = widget.filteredFoodList;

    var listaDeImagens = moradia.listaImagens;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MoradiaPage()),
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
                          color: Colors.purple.withOpacity(.5),
                        ),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              moradia.tituloArtefato,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.none,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              moradia.cidadeMoradia.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.none,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              moradia.bairroMoradia.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
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
                        moradia.descricaoArtefato,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Aluguel total",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "\$",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            moradia.precoAluguelTotalMoradia.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Aluguel por pessoa",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "\$",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            moradia.precoAluguelPorPessoaMoradia.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ButtonHelper.newButton(
              Colors.blue,
              Icons.map_outlined,
              'https://www.google.com/maps/place/',
              moradia.bairroMoradia,
            ),
          ),
        ],
      ),
    );
  }
}
