import 'package:dio/dio.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'dart:async';

import '../constants/constants.dart';
import '../view/login_page/dto/login_response.dart';

class UsuarioRepository {
  final String usuariosUrl = "$onlineApi/usuario";

  Future<List<Usuario>> getAllUsuarios() async {
    try {
      final response = await Dio().get(usuariosUrl);

      if (response.statusCode == 200 && response.statusCode != null) {
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
        throw 'Erro ao cadastrar: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Erro ao acessar a API: $e';
    }
  }

  Future<Usuario> getUsuario(num id) async {
    try {
      String url = '$usuariosUrl/$id';
      final response = await Dio().get(url);
      if (response.statusCode == 200 && response.statusCode != null) {
        final responseData = response.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          Usuario usuario = Usuario.fromJson(responseData);
          return usuario;
        } else {
          throw 'Resposta inválida da API - conteúdo ausente ou inválido';
        }
      } else {
        throw 'Erro na requisição da API';
      }
    } catch (e) {
      throw 'Erro ao acessar a API: $e';
    }
  }

  Future<LoginResponse> logarUsuario(String email, String senha) async {
    try {
      final requestData = {
        "email": email,
        "senha": senha,
      };

      final response = await Dio().post(
        "$onlineApi/usuarioLogar",
        data: requestData,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          Usuario usuario = Usuario.fromJson(responseData);
          return LoginResponse(usuario: usuario, statusCode: 200);
        } else {
          throw 'Resposta inválida da API - conteúdo ausente ou inválido';
        }
      } else if (response.statusCode == 400) {
        final responseData = response.data;
        if (responseData != null &&
            responseData is Map<String, dynamic> &&
            responseData.containsKey('message')) {
          return LoginResponse(usuario: null, statusCode: 400);
        } else {
          throw 'Erro na requisição da API';
        }
      } else {
        throw 'Erro na requisição da API';
      }
    } catch (e) {
      throw 'Erro ao acessar a API: $e';
    }
  }
}
