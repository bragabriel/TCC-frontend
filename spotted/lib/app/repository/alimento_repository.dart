import 'package:dio/dio.dart';
import 'package:spotted/app/model/alimento_model.dart';

class AlimentoRepository {
  final String foodsURL =
      "https://9c0f-45-172-242-15.ngrok-free.app/api/alimento";

  Future<List<Alimento>> getFood() async {
    try {
      final response = await Dio().get(foodsURL);
      print(response.data);
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData != null &&
            responseData['objetoRetorno'] is List<dynamic>) {
          List<Alimento> foodList =
              (responseData['objetoRetorno'] as List<dynamic>)
                  .map<Alimento>((item) => Alimento.fromJson(item))
                  .toList();
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

  Future<void> cadastrarFood(Map<String, dynamic> body) async {
    final String foodsURL =
        "https://9c0f-45-172-242-15.ngrok-free.app/api/alimento";

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
