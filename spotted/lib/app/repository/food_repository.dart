import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:spotted/app/model/food_model.dart';
import '../view/food_page/post_model.dart';

class FoodRepository {
  
  final String foodsURL = "https://6d9c-45-172-242-31.sa.ngrok.io/api/comida?paginaAtual=1&qtdPorPagina=5";

  Future<List<Food>> getFood() async {

    final response = await Dio().get(foodsURL);

    var asd = json.decode(response.data);
    print('asd');
    print(asd.runtimeType);

    if (response.statusCode == 200) {
      // se o servidor retornar um response OK, vamos fazer o parse no JSON
      print(response.statusCode);
      print('oi');
      
      List<dynamic> body = response.data;

        List<Food> foodList = body
          .map(
            (dynamic item) => Food.fromJson(item),
          )
          .toList(); 
        /*
        List<Food> foodList;   final List<dynamic> responseData = response.data;
          foodList = responseData.map((item) => Food.fromJson(item)).toList();
  
          print("minha lista: ");
          print(foodList); 
          */

  
      return foodList;

    } else {
      // se a responsta não for OK , lançamos um erro
      throw "Não foi possível recuperar os dados.";
    }
  }
}
