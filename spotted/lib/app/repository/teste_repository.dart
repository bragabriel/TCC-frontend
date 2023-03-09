import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import '../view/food_page/post_model.dart';

class TesteRepository {
  
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> getPosts() async {
    final response = await Dio().get(postsURL);

    if (response.statusCode == 200) {
      // se o servidor retornar um response OK, vamos fazer o parse no JSON

      print('AAAAAAAAAAAA');
      print(response);

      List<dynamic> body = response.data;

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      // se a responsta não for OK , lançamos um erro
      throw "Não foi possível recuperar os posts.";
    }
  }
}
