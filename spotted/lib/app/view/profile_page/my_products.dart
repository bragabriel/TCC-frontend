import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../home_page/home_view.dart';
import 'options_products.dart';

class MyProductsPage extends StatefulWidget {
  @override
  _MyProductsPageState createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  Usuario? _usuario;

  //   Future<void> _buscarMeusProdutos() async {
  //   try {
  //     await UsuarioRepository().getUsuario(_usuario?.idUsuario as num);
  //     print("GetUsuario com sucesso em MyProductsPage");
  //     setState(() {
  //     });
  //   } catch (e) {
  //     print('Erro ao obter usuario em MyProductsPage: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print("entrou aqui na my products");
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
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          _usuario = UsuarioHelper.getUser(context, userProvider);
          print("\n\n\n\n\n");
          print(_usuario);
          return _listarMeusProdutos();
        },
      ),
    );
  }

  GridView _listarMeusProdutos() {
    print("entrou no listar");
    var listaProdutos = _usuario?.listaArtefatosReponse;

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: listaProdutos?.length ?? 0,
      itemBuilder: (BuildContext ctx, index) {
        var produto = listaProdutos![index];
        var titulo = produto["tituloArtefato"];
        var descricaoArtefato = produto["descricaoArtefato"];

        return InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OptionsProductsPage(produto[index]);
                },
              ),
            );
          },
          child: GridTile(
            key: ValueKey(produto),
            footer: GridTileBar(
              backgroundColor: const Color.fromARGB(137, 107, 98, 98),
              title: Text(
                titulo,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "$descricaoArtefato ",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
                       child: Column(
            children: [
              Expanded(
                child: Image.network(
                   produto["listaImagens"][0]["url"],
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          ),
        );
      },
    );
  }
}
