class Food {
  final int idComida;
  final String nomeComida;
  final String tipoComida;
  final String imagemComida;
  final int idUsuario;

  Food({ 
    required this.idComida,
    required this.nomeComida,
    required this.tipoComida,
    required this.imagemComida,
    required this.idUsuario
    });
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      idComida: json['idComida'],
      nomeComida: json['nomeComida'],
      tipoComida: json['tipoComida'],
      imagemComida: json['imagemComida'],
      idUsuario: json['idUsuario']
    );
  }
}