import 'package:dio/dio.dart';
import 'dart:async';
import 'package:spotted/app/model/moradia_model.dart';

import '../constants/constants.dart';

class MoradiaRepository {
  final String moradiasUrl = "$onlineApi/moradia";

  Future<List<Moradia>> getAllMoradias() async {
    try {
      final response = await Dio().get(moradiasUrl);
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Moradia> moradiaList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Moradia>((item) => Moradia.fromJson(item))
                  .toList();
          return moradiaList;
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