import 'package:flutter/cupertino.dart';
import 'package:spotted/app/model/usuario_model.dart';
import 'package:spotted/app/repository/usuario_repository.dart';

class UsuarioController{
  List<Usuario> listResponse = [];

  final _repository = UsuarioRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  start() async {
    state.value = HomeState.loading;
    try {
      listResponse = await _repository.getAllUsuarios();
      state.value = HomeState.success;
    } catch (e) {
      print(e);
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}