import 'package:dio/dio.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'dart:async';

import '../constants/constants.dart';

class UsuarioRepository {
  final String usuariosUrl = "$onlineApi/usuario";

  Future<List<Usuario>> getAllUsuarios() async {
    try {
      final response = await Dio().get(usuariosUrl);

      print(response);

      if (response.statusCode == 200 && response.statusCode != null) {

        print('entrou');
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Usuario> usuarioList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Usuario>((item) => Usuario.fromJson(item))
                  .toList();
          return usuarioList;
        } else {
          throw 'Resposta inválida da API - conteúdo ausente';
        }
      } else {
        throw 'Erro na requisição da API';
      }
    } catch (e) {
      print('Erro ao acessar a API: $e');
      throw 'Erro ao acessar a API: $e';
    }
  }

  Future<void> cadastrarUsuario(Map<String, dynamic> body) async {
    const String usuariosUrl = "$onlineApi/usuario";

    try {
      final response = await Dio().post(usuariosUrl,
          data: body, options: Options(contentType: 'application/json'));

      if (response.statusCode == 201) {
        print('Cadastro realizado com sucesso');
      } else {
        print('Erro ao cadastrar: ${response.statusCode}');
        print('Mensagem de erro da API: ${response.data}');
        throw 'Erro ao cadastrar: ${response.statusCode}';
      }
    } catch (e) {
      print('Erro ao acessar a API: $e');
      throw 'Erro ao acessar a API: $e';
    }
  }
}
