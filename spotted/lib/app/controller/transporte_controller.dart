import 'package:flutter/cupertino.dart';
import '../model/transporte_model.dart';
import '../repository/transporte_repository.dart';

class TransporteController {
  List<Transporte> listResponse = [];

  final _repository = TransporteRepository();
  final state = ValueNotifier<HomeState>(HomeState.start);

  start() async {
    state.value = HomeState.loading;

    try {
      listResponse = await _repository.getAllTransportes();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
