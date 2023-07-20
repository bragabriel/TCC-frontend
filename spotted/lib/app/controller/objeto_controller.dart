import 'package:flutter/cupertino.dart';
import '../model/objeto_model.dart';
import '../repository/objeto_repository.dart';

class ObjetoController{
  List<Objeto> listResponse = [];

  final _repository = ObjetoRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  start() async {
    state.value = HomeState.loading;
    
    try {
      listResponse = await _repository.getAllObjetos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}