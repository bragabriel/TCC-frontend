import 'package:dio/dio.dart';
import 'package:spotted/app/model/alimento_model.dart';

class FoodRepository {
  final String foodsURL =
      "https://1f18-45-172-242-15.ngrok-free.app/api/alimento?paginaAtual=1&qtdPorPagina=5";

  Future<List<Food>> getFood() async {
    try {
      final response = await Dio().get(foodsURL);
      if (response.statusCode == 200) {
        final responseData = response.data['objetoRetorno']['content'];
        if (responseData != null && responseData is List<dynamic>) {
          List<Food> foodList =
              responseData.map((item) => Food.fromJson(item)).toList();
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
}