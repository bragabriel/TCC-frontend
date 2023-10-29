import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../repository/index.dart';
import '../../../service/user_provider.dart';
import '../alimento_page/alimentoAtualizar_view.dart';
import '../alimento_page/alimentoDeletar_view.dart';
import '../emprego_page/empregoDeletar_view.dart';
import '../emprego_page/empregoAtualizar_view.dart';
import '../evento_page/eventoAtualizar_view.dart';
import '../evento_page/eventoDeletar_view.dart';
import '../home_page/home_view.dart';
import '../moradia_page/moradiaAtualizar_view.dart';
import '../moradia_page/moradiaDeletar_view.dart';
import '../objeto_page/objetoAtualizar_view.dart';
import '../objeto_page/objetoDeletar_view.dart';
import '../transporte_page/transporteAtualizar.view.dart';
import '../transporte_page/transporteDeletar_view.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  _MyProductsPageState createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  final UsuarioRepository usuarioRepository = UsuarioRepository();
  bool _userDataLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!_userDataLoaded) {
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      var response =
          await usuarioRepository.getUsuario(userProvider.user!.idUsuario);
      userProvider.updateUserInfo(response);
      setState(() {
        _userDataLoaded = true;
      });
    } catch (e) {
      print('Erro ao carregar o usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus cadastros no app"),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          var listaProdutos = userProvider.user?.listaArtefatosReponse;
          if (listaProdutos == null || listaProdutos.isEmpty) {
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: 0,
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
              var produto = listaProdutos[index];
              String tipoArtefato = produto["tipoArtefato"];
              return CupertinoContextMenu(
                actions: <Widget>[
                  CupertinoContextMenuAction(
                    child: const Text('Editar'),
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
                              builder: (context) =>
                                  TransporteEditarView(produto),
                            ),
                          );
                          break;
                        default:
                          print("Ocorreu um erro ao editar o produto.");
                      }
                    },
                  ),
                  CupertinoContextMenuAction(
                    child: const Text('Excluir'),
                    onPressed: () {
                      _showAlertDialog(context, tipoArtefato, produto);
                    },
                  ),
                ],
                child: GridTile(
                  key: ValueKey(produto),
                  child: Container(
                    color: CupertinoColors.systemGrey,
                    width: 200,
                    height: 200,
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
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String tipo, dynamic produto) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Cuidado"),
        content: const Text("Você realmente deseja excluir o produto?"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Não'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              // Perform deletion based on 'tipo'
              switch (tipo) {
                case "EMPREGO":
                  EmpregoDeletarView(produto).inativar(context);
                  break;
                case "ALIMENTO":
                  AlimentoDeletarView(produto).inativar(context);
                  break;
                case "EVENTO":
                  EventoDeletarView(produto).inativar(context);
                  break;
                case "OBJETO":
                  ObjetoDeletarView(produto).inativar(context);
                  break;
                case "MORADIA":
                  MoradiaDeletarView(produto).inativar(context);
                  break;
                case "TRANSPORTE":
                  TransporteDeletarView(produto).inativar(context);
                  break;
                default:
                  print("Ocorreu um erro ao deletar o produto.");
              }
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }
}
