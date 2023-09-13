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

  Future<Response<dynamic>> cadastrarMoradia(Map<String, dynamic> body) async {
    const String eventosUrl = "$onlineApi/moradia";

    try {
      final response = await Dio().post(eventosUrl,
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

  Future<void> updateMoradia(
      int idArtefato,
      String descricaoArtefato,
      String tituloArtefato,
      String bairroMoradia,
      String cepMoradia,
      String cidadeMoradia,
      String estadoMoradia,
      num precoAluguelPorPessoa,
      num precoAluguelTotal,
      num qtdMoradoresAtuais,
      num qtdMoradoresPermitidos,
      String vagaGaragem,
      String animaisEstimacao) async {
    final String apiUrl = '$onlineApi/moradiaAtualizar/$idArtefato';

    final Map<String, dynamic> body = {
      "descricaoArtefato": descricaoArtefato,
      "tituloArtefato": tituloArtefato,
      "bairroMoradia": bairroMoradia,
      "cepMoradia": cepMoradia,
      "cidadeMoradia": cidadeMoradia,
      "estadoMoradia": estadoMoradia,
      "precoAluguelPorPessoaMoradia": precoAluguelPorPessoa,
      "precoAluguelTotalMoradia": precoAluguelTotal,
      "qtdMoradoresAtuaisMoradia": qtdMoradoresAtuais,
      "qtdMoradoresPermitidoMoradia": qtdMoradoresPermitidos,
      "vagaGaragemMoradia": vagaGaragem,
      "animaisEstimacaoMoradia": animaisEstimacao,
    };

    try {
      final response = await Dio().put(apiUrl, data: body);

      if (response.statusCode == 200) {
        print('Alimento atualizado com sucesso!');
      } else {
        print(
            'Erro ao atualizar o Alimento - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao atualizar o Alimento: $error');
    }
  }
}
