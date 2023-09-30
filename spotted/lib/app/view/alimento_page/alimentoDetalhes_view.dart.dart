import 'package:flutter/material.dart';
import 'package:spotted/app/view/alimento_page/alimento_view.dart';
import '../../helpers/button_helper.dart';
import '../../model/alimento_model.dart';

class AlimentoDetails extends StatefulWidget {
  @override
  State<AlimentoDetails> createState() => _DetailsState();

  final Alimento filteredFoodList;
  const AlimentoDetails(this.filteredFoodList, {super.key});
}

class _DetailsState extends State<AlimentoDetails> {
  @override
  Widget build(BuildContext context) {
    Alimento alimento = widget.filteredFoodList;

    var listaDeImagens = alimento.listaImagens;

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
                                            builder: (context) =>
                                                AlimentoPage()),
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
                                  Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            alimento.tituloArtefato,
                                            style: const TextStyle(
                                                fontSize: 25,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                          Text(
                                            alimento.saborAlimento as String,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                          Text(
                                            alimento.unidadeAlimento as String,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ))
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
                              alimento.descricaoArtefato,
                              style: TextStyle(
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
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Preço",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
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
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    alimento.precoAlimento.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              ButtonHelper.newButton(
                                  Colors.blue,
                                  Icons.message,
                                  'https://api.whatsapp.com/send/?phone=55',
                                  alimento.telefoneUsuario);
                            },
                            child: Container(
                              height: 60,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "Entrar em contato",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}