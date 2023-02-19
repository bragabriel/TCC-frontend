import 'package:flutter/cupertino.dart';
import 'package:spotted/app/model/food_model.dart';
import 'package:spotted/app/view/food_page/post_model.dart';
import '../repository/food_repository.dart';

class FoodController{
  List<Food> foodList = [];

  final _repository = FoodRepository();

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