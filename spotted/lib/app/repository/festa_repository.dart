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

  Future<void> cadastrarFesta(Map<String, dynamic> body) async {
    const String festasUrl = "$onlineApi/festa";

    try {
      final response = await Dio().post(festasUrl,
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
