import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:spotted/app/model/food_model.dart';
import '../view/food_page/post_model.dart';

class FoodRepository {
  
  final String postsURL = "http://localhost:8080/api/comida?paginaAtual=0&qtdPorPagina=10";

  Future<List<Food>> getFood() async {
    final response = await Dio().get(postsURL);

    if (response.statusCode == 200) {
      // se o servidor retornar um response OK, vamos fazer o parse no JSON
      List<dynamic> body = response.data;

      List<Food> foodList = body
          .map(
            (dynamic item) => Food.fromJson(item),
          )
          .toList();

      return foodList;
    } else {
      // se a responsta não for OK , lançamos um erro
      throw "Não foi possível recuperar os dados.";
    }
  }
}
