import 'dart:convert';
import 'package:http/http.dart';
import 'package:spotted/app/model/usuario_model.dart';

class HttpService {
  final String URL =
      "https://5f3b-45-172-242-15.ngrok-free.app/api/usuario?paginaAtual=1&qtdPorPagina=19";

  List<UsuarioModel> getListaUsuarios() {
    Response res = get(Uri.parse(URL), headers: {"Accept": "application/json"})
        as Response;

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
