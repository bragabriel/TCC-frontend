import 'package:dio/dio.dart';
import 'package:spotted/app/model/alimento_model.dart';
import 'dart:async';

import '../constants/constants.dart';

class AlimentoRepository {
  final String alimentosUrl = "$onlineApi/alimento";

  Future<List<Alimento>> getAllAlimentos() async {
    try {
      final response = await Dio().get(alimentosUrl);
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Alimento> alimentoList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Alimento>((item) => Alimento.fromJson(item))
                  .toList();
          return alimentoList;
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

  Future<Response<dynamic>> cadastrarAlimento(Map<String, dynamic> body) async {
    const String alimentosUrl = "$onlineApi/alimento";

    try {
      final response = await Dio().post(alimentosUrl,
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
}
