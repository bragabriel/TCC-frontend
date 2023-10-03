import 'artefato_model.dart';

class Alimento extends Artefato {
  final String? tipoAlimento;
  final String? marcaAlimento;
  final String? saborAlimento;
  final String? unidadeAlimento;
  final double? precoAlimento;
  final String? ofertaAlimento;
  final String? telefoneUsuario;

  Alimento({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required bool ativo,
    required String tipoArtefato,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required List<Imagem>? listaImagens,
    this.telefoneUsuario,
    this.tipoAlimento,
    this.marcaAlimento,
    this.saborAlimento,
    this.unidadeAlimento,
    this.precoAlimento,
    this.ofertaAlimento,
  }) : super(
          idArtefato: idArtefato,
          tituloArtefato: tituloArtefato,
          descricaoArtefato: descricaoArtefato,
          ativo: ativo,
          tipoArtefato: tipoArtefato,
          dataCadastro: dataCadastro,
          dataAtualizacao: dataAtualizacao,
          idUsuario: idUsuario,
          listaImagens: listaImagens,
        );

  factory Alimento.fromJson(Map<String, dynamic> json) {
    return Alimento(
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
      tipoAlimento: json['tipoAlimento'],
      marcaAlimento: json['marcaAlimento'],
      saborAlimento: json['saborAlimento'],
      unidadeAlimento: json['unidadeAlimento'],
      precoAlimento: json['precoAlimento']?.toDouble(),
      ofertaAlimento: json['ofertaAlimento'],
      telefoneUsuario: json['telefoneUsuario'],
    );
  }
}
