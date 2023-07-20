import 'package:flutter/cupertino.dart';
import 'package:spotted/app/model/emprego_model.dart';
import '../repository/emprego_repository.dart';

class EmpregoController{
  List<Emprego> listResponse = [];

  final _repository = EmpregoRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  start() async {
    state.value = HomeState.loading;
    
    try {
      listResponse = await _repository.getAllEmpregos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}