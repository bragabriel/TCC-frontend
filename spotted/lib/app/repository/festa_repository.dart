import 'package:dio/dio.dart';
import 'package:spotted/app/model/festa_model.dart';
import 'dart:async';

import '../constants/constants.dart';

class FestaRepository {
  final String festasUrl = "$onlineApi/festa";

  Future<List<Festa>> getAllFestas() async {
    try {
      final response = await Dio().get(festasUrl);
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Festa> festaList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Festa>((item) => Festa.fromJson(item))
                  .toList();
          return festaList;
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

  Future<Response<dynamic>> cadastrarFesta(Map<String, dynamic> body) async {
    const String festasUrl = "$onlineApi/festa";

    try {
      final response = await Dio().post(festasUrl,
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

    Future<void> updatefesta(
      int? idArtefato,
      String localizacao,
      String descricaoArtefato,
      String tituloArtefato,
 ) async {
    final String apiUrl = '$onlineApi/festaAtualizar/$idArtefato';

    final Map<String, dynamic> body = {
      "descricaoArtefato": descricaoArtefato,
      "tituloArtefato": tituloArtefato,
      "localizacaoFesta": localizacao
    };

    try {
      final response = await Dio().put(apiUrl, data: body);

      if (response.statusCode == 200) {
        print('festa atualizado com sucesso!');
      } else {
        print(
            'Erro ao atualizar o festa - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao atualizar o festa: $error');
    }
  }
}
