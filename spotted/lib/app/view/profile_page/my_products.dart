import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/alimento_repository.dart';
import 'package:spotted/app/repository/emprego_repository.dart';
import 'package:spotted/app/repository/evento_repository.dart';
import 'package:spotted/app/repository/objeto_repository.dart';
import 'package:spotted/app/repository/transporte_repository.dart';
import 'package:spotted/app/view/alimento_page/alimentoDeletar_view.dart';
import 'package:spotted/app/view/emprego_page/empregoAtualizar_view.dart';
import 'package:spotted/app/view/evento_page/eventoAtualizar_view.dart';
import 'package:spotted/app/view/evento_page/eventoDeletar_view.dart';
import 'package:spotted/app/view/moradia_page/moradiaAtualizar_view.dart';
import 'package:spotted/app/view/moradia_page/moradiaDeletar_view.dart';
import 'package:spotted/app/view/objeto_view/objetoAtualizar_view.dart';
import 'package:spotted/app/view/objeto_view/objetoDeletar_view.dart';
import 'package:spotted/app/view/transporte_page/transporteAtualizar.view.dart';
import 'package:spotted/app/view/transporte_page/transporteDeletar_view.dart';
import '../../../service/change_notifier.dart';
import '../../helpers/usuario_helper.dart';
import '../../model/usuario_model.dart';
import '../alimento_page/alimentoAtualizar_view.dart';
import '../home_page/home_view.dart';
import '../emprego_page/deleteEmprego_view.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  _MyProductsPageState createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  @override
  void initState() {
    _buscarAlimentos();
    _buscarEmpregos();
    _buscarEventos();
    _buscarObjetos();
    _buscarTransportes();
    super.initState();
  }

  Usuario? _usuario;

  @override
  Widget build(BuildContext context) {
    print("Entrou nos meus produtos cadastrados");
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
          _usuario = UsuarioHelper.getUser(context, userProvider);
          return _listarMeusProdutos();
        },
      ),
    );
  }

  GridView _listarMeusProdutos() {
    var listaProdutos = _usuario?.listaArtefatosReponse;
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
        var produto = _usuario?.listaArtefatosReponse?[index];
        String tipoArtefato =
            _usuario?.listaArtefatosReponse?[index]["tipoArtefato"];
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
                          print(tipoArtefato);
                      }
                    },
                  ),
                ),
                PopupMenuItem(
                  child: OutlinedButton(
                    child: const Text('Deletar'),
                    onPressed: () {
                      switch (tipoArtefato) {
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

Future<void> _buscarAlimentos() async {
  try {
    await AlimentoRepository().getAllAlimentos();
    print("GetAllAlimentos com sucesso em AlimentoCadastrarView");
  } catch (e) {
    print('Erro ao obter a lista de alimentos em AlimentoCadastrarView: $e');
  }
}

Future<void> _buscarEmpregos() async {
  try {
    await EmpregoRepository().getAllEmpregos();
    print("GetAllEmpregos com suceso em EmpregoCadastrarView");
  } catch (e) {
    print('Erro ao obter a lista de empregos em EmpregoCadastrarView: $e');
  }
}

Future<void> _buscarEventos() async {
  try {
    await EventoRepository().getAllEventos();
    print("GetAllEventos concluído com sucesso em EventoCadastrarView");
  } catch (e) {
    print('Erro ao obter a lista de eventos em eventoCadastrarView: $e');
  }
}

Future<void> _buscarObjetos() async {
  try {
    await ObjetoRepository().getAllObjetos();
  } catch (e) {
    print('Erro ao obter a lista de objetos: $e');
  }
}

Future<void> _buscarTransportes() async {
  try {
    await TransporteRepository().getAllTransportes();
  } catch (e) {
    print('Erro ao obter a lista de Transportes: $e');
  }
}
