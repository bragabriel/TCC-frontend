class Food {
  final int id_comida;
  final String titulo_comida;
  final String descricao_comida;
  final String tipo_comida;
  final String marca_comida;
  final String oferta_comida;
  final String imagem_comida;
  final int id_usuario;

  Food({ 
    required this.id_comida,
    required this.titulo_comida,
    required this.descricao_comida,
    required this.tipo_comida,
    required this.marca_comida,
    required this.oferta_comida,
    required this.imagem_comida,
    required this.id_usuario
    });
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id_comida: json['idComida'],
      titulo_comida: json['titulo_comida'],
      descricao_comida: json['descricao_comida'],
      tipo_comida: json['tipo_comida'],
      marca_comida: json['marca_comida'],
      oferta_comida: json['oferta_comida'],
      imagem_comida: json['imagem_comida'],
      id_usuario: json['id_usuario']
    );
  }
}