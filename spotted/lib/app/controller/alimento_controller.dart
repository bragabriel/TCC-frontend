import 'package:flutter/cupertino.dart';
import 'package:spotted/app/model/alimento_model.dart';
import '../repository/alimento_repository.dart';

class FoodController{
  List<Alimento> foodList = [];

  final _repository = AlimentoRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    
    try {
      foodList = await _repository.getFood();

      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}