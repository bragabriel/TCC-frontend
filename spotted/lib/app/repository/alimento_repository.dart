import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:spotted/app/model/food_model.dart';
import '../view/alimento_page/post_model.dart';

class FoodRepository {
  
  final String foodsURL = "https://6d9c-45-172-242-31.sa.ngrok.io/api/comida?paginaAtual=1&qtdPorPagina=5";

  Future<List<Food>> getFood() async {

    final response = await Dio().get(foodsURL);

    if (response.statusCode == 200) {
      //List<dynamic> body = json.decode(response.data);
      List<dynamic> body = response.data;

        List<Food> foodList = body
          .map(
            (dynamic item) => Food.fromJson(item),
          )
          .toList();  
      return foodList;

    } else {
      throw "Não foi possível recuperar os dados.";
    }
  }
}