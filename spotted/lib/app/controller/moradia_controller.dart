import 'package:flutter/cupertino.dart';
import '../model/moradia_model.dart';
import '../repository/moradia_repository.dart';

class MoradiaController {
  List<Moradia> listResponse = [];

  final _repository = MoradiaRepository();
  final state = ValueNotifier<HomeState>(HomeState.start);

  start() async {
    state.value = HomeState.loading;

    try {
      listResponse = await _repository.getAllMoradias();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
