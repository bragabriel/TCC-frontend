import 'package:flutter/cupertino.dart';
import '../model/festa_model.dart';
import '../repository/festa_repository.dart';

class FestaController{
  List<Festa> listResponse = [];

  final _repository = FestaRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  start() async {
    state.value = HomeState.loading;
    
    try {
      listResponse = await _repository.getAllFestas();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}