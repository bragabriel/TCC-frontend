import 'dart:convert';
import 'package:http/http.dart';
import 'package:spotted/app/model/usuario_model.dart';

class HttpService {
  final String URL =
      "http://localhost:8080/api/usuario?paginaAtual=0&qtdPorPagina=19";

  Future<List<UsuarioModel>> getListaUsuarios() async {
    Response res =
        await get(Uri.parse(URL), headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      // se o servidor retornar um response OK, vamos fazer o parse no JSON
      List<dynamic> body = jsonDecode(res.body);

      List<UsuarioModel> usuario = body
          .map(
            (dynamic item) => UsuarioModel.fromJson(item),
          )
          .toList();

      print(usuario);

      return usuario;
      
    } else {
      // se a responsta não for OK , lançamos um erro
      throw "Não foi possível recuperar os posts.";
    }
  }
}
