import 'package:dio/dio.dart';
import 'package:spotted/app/model/objeto_model.dart';
import 'dart:async';
import '../constants/constants.dart';

class ObjetoRepository {
  final String objetosUrl = "$onlineApi/objeto";

  Future<List<Objeto>> getAllObjetos() async {
    try {
      final response = await Dio().get(objetosUrl);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Objeto> objetoList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Objeto>((item) => Objeto.fromJson(item))
                  .toList();
          return objetoList;
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

  Future<Response<dynamic>> cadastrarObjeto(Map<String, dynamic> body) async {
    const String objetosUrl = "$onlineApi/objeto";

    try {
      final response = await Dio().post(objetosUrl,
          data: body, options: Options(contentType: 'application/json'));

      if (response.statusCode == 201) {
        print('Cadastro realizado com sucesso');
        return response;
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

  Future<void> updateObjeto(Map<String, dynamic> body, int? idArtefato) async {
    final String apiUrl = '$onlineApi/objetoAtualizar/$idArtefato';
    try {
      final response = await Dio().post(apiUrl, data: body);

      if (response.statusCode == 200) {
        print('objeto atualizado com sucesso!');
      } else {
        print(
            'Erro ao atualizar o objeto - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao atualizar o objeto: $error');
    }
  }
}
