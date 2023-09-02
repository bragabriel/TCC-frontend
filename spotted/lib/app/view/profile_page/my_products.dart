import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/alimento_page/alimentoCadastrar_view.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/alimento_model.dart';
import '../../model/usuario_model.dart';
import '../home_page/home_view.dart';
import 'updateAlimento.dart';
import 'options_products.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';

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
              trailing: PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: OutlinedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AlimentoEditarView(produto)));
                        print("meu deusssssssssssssssssss");
                        print(produto);
                        print(produto['tituloArtefato']);
                        print(produto['tipoAlimento']);
                        print(produto['unidadeAlimento']);
                        print(produto['ofertaAlimento']);
                        print(produto['precoAlimento'].toString());
                        print(produto['saborAlimento']);
                        print(produto['marcaAlimento']);
                        print(produto['descricaoArtefato']);
                        // print(produto);
                        // switch (produto) {
                        //   case 1:
                        //     AlimentoEditarView(produto);
                        //     break;
                        // case 2:
                        //   message = 'Option 2 selected';
                        //   break;
                        // case 3:
                        //   message = 'Option 3 selected';
                        //   break;
                        // default:
                        //   message = 'Invalid option';
                        // }
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
          ),
        );
      },
    );
  }
}
