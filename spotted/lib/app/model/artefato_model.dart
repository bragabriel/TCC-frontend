class Artefato {
  final int idArtefato;
  final String tituloArtefato;
  String descricaoArtefato;

  final bool ativo;
  final String dataCadastro;
  final String? dataAtualizacao;
  final int idUsuario;
  final List<Imagem>? listaImagens;
  final String tipoArtefato;

  Artefato({
    required this.idArtefato,
    required this.tituloArtefato,
    required this.descricaoArtefato,
    required this.ativo,
    required this.tipoArtefato,
    required this.dataCadastro,
    required this.idUsuario,
    required this.listaImagens,
    required this.dataAtualizacao,
  });

  factory Artefato.fromJson(Map<String, dynamic> json) {
    return Artefato(
      idArtefato: json['idArtefato'],
      tituloArtefato: json['tituloArtefato'],
      descricaoArtefato: json['descricaoArtefato'],
      ativo: json['ativo'],
      tipoArtefato: json['tipoArtefato'],
      dataCadastro: json['dataCadastro'],
      dataAtualizacao: json['dataAtualizacao'],
      idUsuario: json['idUsuario'],
      listaImagens: (json['listaImagens'] as List<dynamic>)
          .map((image) => Imagem.fromJson(image))
          .toList(),
    );
  }
}

class Imagem {
  final int idImage;
  // final String localUrl;
  final String url;
  final int sequence;
  final String fileName;
  final int idArtefato;

  Imagem({
    required this.idImage,
    // required this.localUrl,
    required this.url,
    required this.sequence,
    required this.fileName,
    required this.idArtefato,
  });

  factory Imagem.fromJson(Map<String, dynamic> json) {
    return Imagem(
      idImage: json['idImage'],
      // localUrl: json['localUrl'],
      url: json['url'],
      sequence: json['sequence'],
      fileName: json['fileName'],
      idArtefato: json['idArtefato'],
    );
  }
}
