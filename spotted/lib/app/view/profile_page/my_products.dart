import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/profile_page/updateEmprego.dart';
import 'package:spotted/app/view/profile_page/updateEvento.dart';
import 'package:spotted/app/view/profile_page/updateMoradia.dart';
import 'package:spotted/app/view/profile_page/updateObjeto.dart';
import 'package:spotted/app/view/profile_page/updateTransporte.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../home_page/home_view.dart';
import 'updateAlimento.dart';

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
          return _listarMeusProdutos();
        },
      ),
    );
  }

  GridView _listarMeusProdutos() {
    print("entrou no listar");
    var listaProdutos = _usuario?.listaArtefatosReponse;

    if (listaProdutos == null || listaProdutos.isEmpty) {
      // Handle the case where the list is null or empty.
      return GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: 0, // No items to display.
        itemBuilder: (BuildContext ctx, index) {
          return GridTile(
            child: Container(),
          );
        },
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: listaProdutos.length,
      itemBuilder: (BuildContext ctx, index) {
        var produto = _usuario?.listaArtefatosReponse?[index];
        String tipoArtefato =
            _usuario?.listaArtefatosReponse?[index]["tipoArtefato"];
        print(tipoArtefato);
        return GridTile(
          key: ValueKey(produto),
          footer: GridTileBar(
            backgroundColor: const Color.fromARGB(137, 107, 98, 98),
            title: Text(
              _usuario?.listaArtefatosReponse?[index]["tituloArtefato"],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _usuario?.listaArtefatosReponse?[index]["descricaoArtefato"],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: OutlinedButton(
                    child: Text('Editar'),
                    onPressed: () {
                      switch (tipoArtefato) {
                        case "EMPREGO":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmpregoEditarView(produto),
                            ),
                          );
                          break;
                        case "ALIMENTO":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlimentoEditarView(produto),
                            ),
                          );
                          break;
                        case "EVENTO":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventoEditarView(produto),
                            ),
                          );
                          break;
                        case "OBJETO":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ObjetoEditarView(produto),
                            ),
                          );
                          break;
                        case "MORADIA":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoradiaEditarView(produto),
                            ),
                          );
                          break;
                        case "TRANSPORTE":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransporteEditarView(produto),
                            ),
                          );
                          break;
                        default:
                          print("deu problema");
                          print(tipoArtefato);
                      }
                    },
                  ),
                ),
                PopupMenuItem(
                  child: OutlinedButton(
                    child: Text('Deletar'),
                    onPressed: () {
                      setState(() {
                        produto!.removeAt(index);
                      });
                    },
                  ),
                ),
              ],
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
        );
      },
    );
  }
}
