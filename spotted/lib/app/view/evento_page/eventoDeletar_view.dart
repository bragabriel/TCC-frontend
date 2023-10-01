import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class EventoDeletarView {
  final dynamic evento;
  EventoDeletarView(this.evento);

  void _showSuccessMessage(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Produto deletado com sucesso!'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void inativar(BuildContext context) {
    print("entrou  no delete");
    _inativarArtefato(evento['idArtefato']);
    _showSuccessMessage(context);
  }

void _inativarArtefato(int idArtefato) async {
    final String apiUrl = '$onlineApi/eventoInativar/$idArtefato';
    try {
      final response = await Dio().put(apiUrl);

      if (response.statusCode == 200) {
        print('Evento deletado comm sucesso!');
      } else {
        print('Erro ao deletar Evento - Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao deletar o Evento: $error');
    }
  }
}
