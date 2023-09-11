import 'package:flutter/cupertino.dart';
import '../model/evento_model.dart';
import '../repository/evento_repository.dart';

class EventoController{
  List<Evento> listResponse = [];

  final _repository = EventoRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  start() async {
    state.value = HomeState.loading;
    
    try {
      listResponse = await _repository.getAllEventos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}