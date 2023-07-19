import 'package:dio/dio.dart';
import 'package:spotted/app/model/alimento_model.dart';
import 'dart:async';

class AlimentoRepository {
  final String foodsURL =
      "https://50f8-45-172-242-15.ngrok-free.app/api/alimento?paginaAtual=2&qtdPorPagina=10";

  FutureOr<List<Alimento>> getFood() {
    try {
      final response = Dio().get(foodsURL);
      if (response == 200) {
        final responseData = response['objetoRetorno']['content'];
        if (responseData != null && responseData is List<dynamic>) {
          List<Alimento> foodList =
              responseData.map((item) => Alimento.fromJson(item)).toList();
          return foodList;
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

  void cadastrarFood(Map<String, dynamic> body) async {
    final String foodsURL =
        "https://efdc-45-172-242-15.ngrok-free.app/api/alimento";

    try {
      final response = await Dio().post(foodsURL,
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
