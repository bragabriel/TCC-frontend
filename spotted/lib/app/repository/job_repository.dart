import 'package:dio/dio.dart';
import 'package:spotted/app/model/job_model.dart';
import '../view/food_page/food_model.dart';

class JobsRepository {
  
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Job>> getJobs() async {

    final response = await Dio().get(postsURL);

    if (response.statusCode == 200) {
      // se o servidor retornar um response OK, vamos fazer o parse no JSON
      List<dynamic> body = response.data;
      List<Job> posts = body
          .map(
            (dynamic item) => Job.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      // se a responsta não for OK , lançamos um erro
      throw "Não foi possível recuperar os posts.";
    }
  }
}
