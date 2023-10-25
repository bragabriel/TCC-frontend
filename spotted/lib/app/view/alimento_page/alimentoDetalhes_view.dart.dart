import 'package:flutter/material.dart';
import 'package:spotted/app/constants/constants.dart';
import 'package:spotted/app/helpers/image_helper.dart';
import 'package:spotted/app/view/alimento_page/alimento_view.dart';
import '../../helpers/button_helper.dart';
import '../../model/alimento_model.dart';

class AlimentoDetails extends StatelessWidget {
  final Alimento filteredFoodList;

  const AlimentoDetails(this.filteredFoodList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Alimento alimento = filteredFoodList;
    var listaDeImagens = alimento.listaImagens;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AlimentoPage()),
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
                              alimento.tituloArtefato,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.none,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              alimento.saborAlimento as String,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.none,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              alimento.ofertaAlimento.toString(),
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
                        alimento.descricaoArtefato,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Preço",
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
                            alimento.precoAlimento.toString(),
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
              Icons.message,
              'https://api.whatsapp.com/send/?phone=55',
              alimento.telefoneUsuario,
            ),
          ),
        ],
      ),
    );
  }
}
