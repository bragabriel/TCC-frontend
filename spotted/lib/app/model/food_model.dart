class Food {
  final int id_artefato;
  final String titulo_artefato;
  final String descricao_artefato;
  final String tipo_alimento;
  final String marca_alimento;
  final String sabor_alimento;
  final String unidade_alimento;
  final double preco_alimento;
  final String oferta_alimento;
  //final String imagem_alimento;

  Food({
    required this.id_artefato,
    required this.titulo_artefato,
    required this.descricao_artefato,
    required this.tipo_alimento,
    required this.marca_alimento,
    required this.sabor_alimento,
    required this.unidade_alimento,
    required this.preco_alimento,
    required this.oferta_alimento,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id_artefato: json['idArtefato'] ?? 0,
      titulo_artefato: json['tituloArtefato'] ?? '',
      descricao_artefato: json['descricaoArtefato'] ?? '',
      tipo_alimento: json['tipoAlimento'] ?? '',
      marca_alimento: json['marcaAlimento'] ?? '',
      sabor_alimento: json['saborAlimento'] ?? '',
      unidade_alimento: json['unidadeAlimento'] ?? '',
      preco_alimento: json['precoAlimento']?.toDouble() ?? 0.0,
      oferta_alimento: json['ofertaAlimento'] ?? '',
    );
  }
}
