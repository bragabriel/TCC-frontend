import 'package:flutter/material.dart';

void showSuccessMessage(BuildContext context) {
  const snackBar = SnackBar(
    content: Text('Cadastro realizado com sucesso!'),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorMessage(BuildContext context) {
  const snackBar = SnackBar(
    content: Text('Erro ao cadastrar. Por favor, tente novamente!'),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
