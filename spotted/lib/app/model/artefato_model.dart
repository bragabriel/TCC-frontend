class Artefato {
  final int idArtefato;
  final String tituloArtefato;
  final String descricaoArtefato;
  final String tipoArtefato;
  final bool ativo;
  final String dataCadastro;
  final String? dataAtualizacao;
  final int idUsuario;
  final List<Imagem> listaImagens;

  Artefato({
    required this.idArtefato,
    required this.tituloArtefato,
    required this.descricaoArtefato,
    required this.tipoArtefato,
    required this.ativo,
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
      tipoArtefato: json['tipoArtefato'],
      ativo: json['ativo'],
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
  final String url;
  final int sequence;
  final String fileName;
  final int idArtefato;

  Imagem({
    required this.idImage,
    required this.url,
    required this.sequence,
    required this.fileName,
    required this.idArtefato,
  });

  factory Imagem.fromJson(Map<String, dynamic> json) {
    return Imagem(
      idImage: json['idImage'],
      url: json['url'],
      sequence: json['sequence'],
      fileName: json['fileName'],
      idArtefato: json['idArtefato'],
    );
  }
}