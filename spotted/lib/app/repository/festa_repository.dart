import 'package:dio/dio.dart';
import 'package:spotted/app/model/Evento_model.dart';
import 'dart:async';

import '../constants/constants.dart';

class EventoRepository {
  final String eventosUrl = "$onlineApi/evento";

  Future<List<Evento>> getAllEventos() async {
    try {
      final response = await Dio().get(eventosUrl);
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Evento> eventoList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Evento>((item) => Evento.fromJson(item))
                  .toList();
          return eventoList;
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

  Future<Response<dynamic>> cadastrarEvento(Map<String, dynamic> body) async {
    const String eventosUrl = "$onlineApi/evento";

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

    Future<void> updateevento(
      int? idArtefato,
      String localizacao,
      String descricaoArtefato,
      String tituloArtefato,
 ) async {
    final String apiUrl = '$onlineApi/eventoAtualizar/$idArtefato';

    final Map<String, dynamic> body = {
      "descricaoArtefato": descricaoArtefato,
      "tituloArtefato": tituloArtefato,
      "localizacaoEvento": localizacao
    };

    try {
      final response = await Dio().put(apiUrl, data: body);

      if (response.statusCode == 200) {
        print('evento atualizado com sucesso!');
      } else {
        print(
            'Erro ao atualizar o evento - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao atualizar o evento: $error');
    }
  }
}
