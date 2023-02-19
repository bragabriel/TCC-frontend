import 'dart:ffi';

class UsuarioModel {
  int idUsuario;
  String nomeUsuario;
  String sobrenomeUsuario;
  String emailUsuario;
  String senhaUsuario;
  String telefoneUsuario;
  String descricaoUsuario;
  String image;

  // Constructor
  UsuarioModel({
    
    required this.idUsuario,
    required this.nomeUsuario,
    required this.sobrenomeUsuario,
    required this.emailUsuario,
    required this.senhaUsuario,
    required this.telefoneUsuario,
    required this.descricaoUsuario,
    required this.image,
  });

  UsuarioModel copy({
    
    int? idUsuario,
    String? nomeUsuario,
    String? sobrenomeUsuario,
    String? emailUsuario,
    String? senhaUsuario,
    String? telefoneUsuario,
    String? descricaoUsuario,
    String? imagePath,
  }) =>
      UsuarioModel(
        idUsuario: idUsuario ?? this.idUsuario,
        nomeUsuario: nomeUsuario ?? this.nomeUsuario,
        sobrenomeUsuario: sobrenomeUsuario ?? this.sobrenomeUsuario,
        emailUsuario: emailUsuario ?? this.emailUsuario,
        senhaUsuario: senhaUsuario ?? this.senhaUsuario,
        telefoneUsuario: telefoneUsuario ?? this.telefoneUsuario,
        descricaoUsuario: descricaoUsuario ?? this.descricaoUsuario,
        image: imagePath ?? this.image,
      );

  static UsuarioModel fromJson(Map<String, dynamic> json) => UsuarioModel(
        idUsuario: json['idUsuario'],
        nomeUsuario: json['nomeUsuario'],
        sobrenomeUsuario: json['sobrenomeUsuario'],
        emailUsuario: json['emailUsuario'],
        senhaUsuario: json['senhaUsuario'],
        descricaoUsuario: json['descricaoUsuario'],
        telefoneUsuario: json['telefoneUsuario'],
        image: json['imagePath'],
      );

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'nomeUsuario': nomeUsuario,
        'sobrenomeUsuario': sobrenomeUsuario,
        'emailUsuario': emailUsuario,
        'senhaUsuario': senhaUsuario,
        'descricaoUsuario': descricaoUsuario,
        'telefoneUsuario': telefoneUsuario,
        'imagePath': image,
      };
}
