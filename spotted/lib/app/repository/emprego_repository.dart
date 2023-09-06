import 'package:dio/dio.dart';
import 'package:spotted/app/model/emprego_model.dart';
import 'dart:async';

import '../constants/constants.dart';

class EmpregoRepository {
  final String empregosUrl = "$onlineApi/emprego";

  Future<List<Emprego>> getAllEmpregos() async {
    try {
      final response = await Dio().get(empregosUrl);
      print(response.data);
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

  Future<void> updateEmprego(
      int? idArtefato,
      String tituloArtefato,
      String descricaoArtefato,
      String? localizacaoEmprego,
      String? requisitosEmprego,
      num? salarioEmprego,
      String? beneficiosEmprego,
      String? contatoEmprego,
      String? linkVagaEmprego,
      String? empresaEmprego,
      String? cidadeEmprego,
      String? estadoEmprego,
      String? experienciaEmprego,
      String? tipoVagaEmprego,
      String? presencialEmprego) async {
    final String apiUrl = '$onlineApi/empregoAtualizar/$idArtefato';

    final Map<String, dynamic> body = {
      "descricaoArtefato": descricaoArtefato,
      "tituloArtefato": tituloArtefato,
      "localizacaoEmprego": localizacaoEmprego,
      "requisitosEmprego": requisitosEmprego,
      "salarioEmprego": salarioEmprego,
      "beneficiosEmprego": beneficiosEmprego,
      "contatoEmprego": contatoEmprego,
      "linkVagaEmprego": linkVagaEmprego,
      "empresaEmprego": empresaEmprego,
      "cidadeEmprego": cidadeEmprego,
      "estadoEmprego": estadoEmprego,
      "experienciaEmprego": experienciaEmprego,
      "tipoVagaEmprego": tipoVagaEmprego,
      "presencialEmprego": presencialEmprego,
    };

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
