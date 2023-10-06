import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class MoradiaDeletarView {
  final dynamic moradia;
  MoradiaDeletarView(this.moradia);

  void _showSuccessMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Produto deletado com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void inativar(BuildContext context) {
    print("entrou  no delete");
    _inativarArtefato(moradia['idArtefato']);
    _showSuccessMessage(context);
  }

void _inativarArtefato(int idArtefato) async {
    final String apiUrl = '$onlineApi/moradiaInativar/$idArtefato';
    try {
      final response = await Dio().put(apiUrl);

      if (response.statusCode == 200) {
        print('Moradia deletado com sucesso!');
      } else {
        print('Erro ao deletar Moradia - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao deletar o Moradia: $error');
    }
  }
}
