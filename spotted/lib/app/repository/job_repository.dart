import 'package:dio/dio.dart';
import '../model/job_model.dart';

class JobRepository {
  
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<JobModel>> getJobModels() async {

    final response = await Dio().get(postsURL);

    if (response.statusCode == 200) {
      // se o servidor retornar um response OK, vamos fazer o parse no JSON
      List<dynamic> body = response.data;
      List<JobModel> posts = body
          .map(
            (dynamic item) => JobModel.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      // se a responsta não for OK , lançamos um erro
      throw "Não foi possível recuperar os posts.";
    }
  }
}
