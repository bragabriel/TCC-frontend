import 'package:dio/dio.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'package:spotted/service/prefs_service.dart';
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
      throw 'Erro ao acessar a API em get all usuarios: $e';
    }
  }

  Future<Response<dynamic>> cadastrarUsuario(Map<String, dynamic> body) async {
    const String usuariosUrl = "$onlineApi/usuario";

    try {
      final response = await Dio().post(usuariosUrl,
          data: body, options: Options(contentType: 'application/json'));

      if (response.statusCode == 201) {
        return response;
      } else {
        throw 'Erro ao cadastrar: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Erro ao acessar a API em cadastrar usuario: $e';
    }
  }

  Future<Usuario> getUsuario(int id) async {
    final dio = Dio();
    try {
      final response = await dio.get('$onlineApi/usuario/$id');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final Map<String, dynamic> usuarioData = data['objetoRetorno'];
        return Usuario.fromJson(usuarioData);
      } else {
        throw Exception('Falha ao carregar o usuário');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
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

          //salvando infos prefs
          PrefsService.save(usuario.emailUsuario);
          PrefsService.saveUser(usuario);

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
      throw 'Erro ao acessar a API em logar usuario: $e';
    }
  }

  Future<void> updateUserName(
      int idUsuario, String nomeUsuario, String sobrenomeUsuario) async {
    final String apiUrl = '$onlineApi/usuarioAtualizar/$idUsuario';

    final Map<String, dynamic> body = {
      'nomeUsuario': nomeUsuario,
      'sobrenomeUsuario': sobrenomeUsuario,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await Dio().put(apiUrl, data: body);

      if (response.statusCode == 200) {
        print('Usuário atualizado com sucesso!');
      } else {
        print('Erro ao atualizar o usuário - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao atualizar o usuário: $error');
    }
  }
}
