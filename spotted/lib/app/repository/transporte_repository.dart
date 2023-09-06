import 'package:dio/dio.dart';
import 'package:spotted/app/model/transporte_model.dart';
import 'dart:async';

import '../constants/constants.dart';

class TransporteRepository {
  final String transportesUrl = "$onlineApi/transporte";

  Future<List<Transporte>> getAllTransportes() async {
    try {
      final response = await Dio().get(transportesUrl);
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Transporte> transporteList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Transporte>((item) => Transporte.fromJson(item))
                  .toList();
          return transporteList;
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

  Future<Response<dynamic>> cadastrarTransporte(
      Map<String, dynamic> body) async {
    const String transportesUrl = "$onlineApi/transporte";

    try {
      final response = await Dio().post(transportesUrl,
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

  Future<void> updateTransporte(
      int idArtefato,
      String descricaoArtefato,
      String tituloArtefato,
      String cidadeTransporte,
      String informacoesCondutorTransporte,
      String informacoesVeiculoTransporte,
      String periodoTransporte,
      int qtdAssentosPreenchidosTransporte,
      int qtdAssentosTotalTransporte,
      String valorTransporte) async {
    final String apiUrl = '$onlineApi/transporteAtualizar/$idArtefato';

    final Map<String, dynamic> body = {
      "descricaoArtefato": descricaoArtefato,
      "tituloArtefato": tituloArtefato,
      "cidadeTransporte": cidadeTransporte,
      "informacoesCondutorTransporte": informacoesCondutorTransporte,
      "informacoesVeiculoTransporte": informacoesVeiculoTransporte,
      "periodoTransporte": periodoTransporte,
      "qtdAssentosPreenchidosTransporte": qtdAssentosPreenchidosTransporte,
      "qtdAssentosTotalTransporte": qtdAssentosTotalTransporte,
      "valorTransporte": valorTransporte
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
