import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class TransporteDeletarView {
  final dynamic transporte;
  TransporteDeletarView(this.transporte);

  void _showSuccessMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Produto deletado com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> inativar(BuildContext context) {
    print("entrou  no delete");
   return _inativarArtefato(transporte['idArtefato'], context);
  }

  Future<bool> _inativarArtefato(int idArtefato, context) async {
    final String apiUrl = '$onlineApi/transporteInativar/$idArtefato';
    try {
      final response = await Dio().put(apiUrl);

      if (response.statusCode == 200) {
        print('Transporte deletado comm sucesso!');
    _showSuccessMessage(context);

        return true;
      } else {
        print(
            'Erro ao deletar Transporte - Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Erro ao deletar o Transporte: $error');
    }
    return false;
  }
}
