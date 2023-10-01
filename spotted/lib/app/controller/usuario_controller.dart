import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/repository/usuario_repository.dart';
import '../../service/change_notifier.dart';
import '../model/usuario_model.dart';

class UsuarioController {
  final _repository = UsuarioRepository();

  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        Usuario? user = userProvider.user;
        return UserAccountsDrawerHeader(
          // utilizando o usuario
          accountName: Text(user?.nomeUsuario ?? 'Usuário não logado'),
          accountEmail: Text(user?.emailUsuario ?? ''),
        );
      },
    );
  }

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future<void> start(BuildContext context) async {
    state.value = HomeState.loading;
    
    try {
      Usuario? user = Provider.of<UserProvider>(context, listen: false).user;

      await _repository.getUsuario(user!.idUsuario);
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }

   Future<void> startCadastro() async {
    state.value = HomeState.loading;
    try {
      await _repository.getAllUsuarios();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
