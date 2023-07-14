import 'package:flutter/cupertino.dart';
import 'package:spotted/app/repository/teste_repository.dart';
import 'package:spotted/app/view/alimento_page/post_model.dart';

class TesteController{
  List<Post> todos = [];

  final _repository = TesteRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    
    try {
      todos = await _repository.getPosts();

      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}