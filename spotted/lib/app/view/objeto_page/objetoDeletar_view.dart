import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../usuario_page/perfil_view.dart';

class ObjetoDeletarView {
  final dynamic objeto;
  ObjetoDeletarView(this.objeto);

  void _showSuccessMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Produto deletado com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void inativar(BuildContext context) {
    print("entrou  no delete");
    _inativarArtefato(objeto['idArtefato']);
    _showSuccessMessage(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void _inativarArtefato(int idArtefato) async {
    final String apiUrl = '$onlineApi/objetoInativar/$idArtefato';
    try {
      final response = await Dio().put(apiUrl);

      if (response.statusCode == 200) {
        print('Objeto deletado comm sucesso!');
      } else {
        print('Erro ao deletar Objeto - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao deletar o Objeto: $error');
    }
  }
}
