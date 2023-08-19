import 'package:flutter/material.dart';
import 'package:spotted/app/view/transporte_page/transporteCadastrar_view.dart';
import 'options_products.dart';
import '../../helpers/image_helper.dart';
import '../../model/usuario_model.dart';
import '../home_page/home_view.dart';


class MyProductsPage extends StatefulWidget {
  @override
  MyProductsPageState createState() => MyProductsPageState();

  final Usuario? usuario;
  const MyProductsPage(this.usuario, {super.key});
}

class MyProductsPageState extends State<MyProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  List<dynamic>? listaProdutos;

  @override
  Widget build(BuildContext context) {
    listaProdutos = widget.usuario!.listaArtefatosReponse;
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus cadastros no app"),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: _construirFiltrosELista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransporteCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Widget _construirFiltrosELista() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: listaProdutos?.length,
        itemBuilder: (BuildContext ctx, index) {
          return InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OptionsProductsPage(listaProdutos![index]);
                    },
                  ),
                );
              },
              child: GridTile(
                key: ValueKey(listaProdutos![index].idArtefato),
                footer: GridTileBar(
                  backgroundColor: const Color.fromARGB(137, 107, 98, 98),
                  title: Text(
                    listaProdutos![index].tituloArtefato,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                child: ImageHelper.buildCarrousel(
                    listaProdutos![index].listaImagens),
              ));
        },
      ),
    );
  }
}
