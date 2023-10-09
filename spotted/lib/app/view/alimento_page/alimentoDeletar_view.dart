import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/view/profile_page/perfil_view.dart';
import '../../constants/constants.dart';

class AlimentoDeletarView {
  final dynamic alimento;
  AlimentoDeletarView(this.alimento);

  void _showSuccessMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Produto deletado com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void inativar(BuildContext context) {
    print("entrou  no delete");
    _inativarArtefato(alimento['idArtefato']);
    _showSuccessMessage(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void _inativarArtefato(int idArtefato) async {
    final String apiUrl = '$onlineApi/alimentoInativar/$idArtefato';
    try {
      final response = await Dio().put(apiUrl);

      if (response.statusCode == 200) {
        print('Alimento deletado comm sucesso!');
      } else {
        print('Erro ao deletar Alimento - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao deletar o Alimento: $error');
    }
  }
}
