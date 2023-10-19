import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../usuario_page/perfil_view.dart';

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

  void inativar(BuildContext context) {
    print("entrou  no delete");
    _inativarArtefato(transporte['idArtefato']);
    _showSuccessMessage(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void _inativarArtefato(int idArtefato) async {
    final String apiUrl = '$onlineApi/transporteInativar/$idArtefato';
    try {
      final response = await Dio().put(apiUrl);

      if (response.statusCode == 200) {
        print('transporte deletado comm sucesso!');
      } else {
        print('Erro ao deletar transporte - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao deletar o transporte: $error');
    }
  }
}
