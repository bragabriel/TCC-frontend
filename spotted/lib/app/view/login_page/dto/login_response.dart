import '../../../model/usuario_model.dart';

class LoginResponse {
  final Usuario? usuario;
  final int statusCode;

  LoginResponse({required this.usuario, required this.statusCode});
}