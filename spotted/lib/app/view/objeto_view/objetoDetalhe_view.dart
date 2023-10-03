import 'package:flutter/material.dart';
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
                                top: 50, left: 20, right: 20),
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
                                            builder: (context) => const ObjetoPage()),
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_back_ios_new))
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
                                            objeto.tituloArtefato,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.none,
                                            ),
                                            softWrap: true,
                                          ),
                                          Text(
                                           objeto.localizacaoAchadoObjeto as String,
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
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 30),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SingleChildScrollView(
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
                              height: 20,
                            ),
                            Text(
                              objeto.descricaoArtefato,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Localização atual: ",
                              style: TextStyle(
                                color: Colors.black.withOpacity(.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              objeto.descricaoArtefato,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
