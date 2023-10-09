import 'package:dio/dio.dart';
import 'package:spotted/app/model/emprego_model.dart';
import 'dart:async';

import '../constants/constants.dart';

class EmpregoRepository {
  final String empregosUrl = "$onlineApi/emprego";

  Future<List<Emprego>> getAllEmpregos() async {
    try {
      final response = await Dio().get(empregosUrl);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Emprego> empregoList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Emprego>((item) => Emprego.fromJson(item))
                  .toList();
          return empregoList;
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

  Future<Response<dynamic>> cadastrarEmprego(Map<String, dynamic> body) async {
    const String empregosUrl = "$onlineApi/emprego";

    try {
      final response = await Dio().post(empregosUrl,
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

  Future<void> updateEmprego(Map<String, dynamic> body,
      int? idArtefato) async {
    final String apiUrl = '$onlineApi/empregoAtualizar/$idArtefato';

    try {
      final response = await Dio().put(apiUrl, data: body);

      if (response.statusCode == 200) {
        print('Emprego atualizado com sucesso!');
      } else {
        print(
            'Erro ao atualizar o Emprego - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao atualizar o Emprego: $error');
    }
  }
}
