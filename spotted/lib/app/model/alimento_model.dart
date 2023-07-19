import 'artefato_model.dart';

class Alimento extends Artefato {
  final String? tipoAlimento;
  final String? marcaAlimento;
  final String? saborAlimento;
  final String? unidadeAlimento;
  final double? precoAlimento;
  final String? ofertaAlimento;

  Alimento({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required String tipoArtefato,
    required bool ativo,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required List<Imagem> listaImagens,
    this.tipoAlimento,       // Alteração para aceitar null
    this.marcaAlimento,      // Alteração para aceitar null
    this.saborAlimento,      // Alteração para aceitar null
    this.unidadeAlimento,    // Alteração para aceitar null
    this.precoAlimento,      // Alteração para aceitar null
    this.ofertaAlimento,     // Alteração para aceitar null
  }) : super(
          idArtefato: idArtefato,
          tituloArtefato: tituloArtefato,
          descricaoArtefato: descricaoArtefato,
          tipoArtefato: tipoArtefato,
          ativo: ativo,
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
      tipoArtefato: json['tipoArtefato'],
      ativo: json['ativo'],
      dataCadastro: json['dataCadastro'],
      dataAtualizacao: json['dataAtualizacao'], // Remoção da conversão, mantendo o valor como String?
      idUsuario: json['idUsuario'],
      listaImagens: (json['listaImagens'] as List<dynamic>)
          .map((image) => Imagem.fromJson(image))
          .toList(),
      tipoAlimento: json['tipoAlimento'],
      marcaAlimento: json['marcaAlimento'],
      saborAlimento: json['saborAlimento'],
      unidadeAlimento: json['unidadeAlimento'],
      precoAlimento: json['precoAlimento']?.toDouble(), // Uso do operador ? para converter para double ou aceitar null
      ofertaAlimento: json['ofertaAlimento'],
    );
  }
}