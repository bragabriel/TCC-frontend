import 'package:dio/dio.dart';
import 'dart:async';

import '../constants/constants.dart';
import '../model/evento_model.dart';

class EventoRepository {
  final String eventosUrl = "$onlineApi/evento";

  Future<List<Evento>> getAllEventos() async {
    try {
      final response = await Dio().get(eventosUrl);
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

  Future<void> updateEvento(Map<String, dynamic> body, int? idArtefato) async {
    final String apiUrl = '$onlineApi/eventoAtualizar/$idArtefato';

    try {
      final response = await Dio().post(apiUrl, data: body);

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
