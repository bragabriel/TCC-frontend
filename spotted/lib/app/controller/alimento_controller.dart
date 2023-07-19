import 'package:flutter/cupertino.dart';
import 'package:spotted/app/model/alimento_model.dart';
import '../repository/alimento_repository.dart';

class AlimentoController{
  List<Alimento> alimentoList = [];

  final _repository = AlimentoRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  start() async {
    state.value = HomeState.loading;
    
    try {
      alimentoList = await _repository.getAllAlimentos();

      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}