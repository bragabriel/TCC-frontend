import 'artefato_model.dart';

class Evento extends Artefato {
  final String? localizacaoEvento;

  Evento({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required bool ativo,
    required String tipoArtefato,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required Imagem imagem,
    required this.localizacaoEvento,
  }) : super(
          idArtefato: idArtefato,
          tituloArtefato: tituloArtefato,
          descricaoArtefato: descricaoArtefato,
          ativo: ativo,
          tipoArtefato: tipoArtefato,
          dataCadastro: dataCadastro,
          dataAtualizacao: dataAtualizacao,
          idUsuario: idUsuario,
          imagem: imagem,
        );

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      idArtefato: json['idArtefato'],
      tituloArtefato: json['tituloArtefato'],
      descricaoArtefato: json['descricaoArtefato'],
      ativo: json['ativo'],
      tipoArtefato: json['tipoArtefato'],
      dataCadastro: json['dataCadastro'],
      dataAtualizacao: json['dataAtualizacao'],
      idUsuario: json['idUsuario'],
      imagem: (json['imagem'])
          .map((image) => Imagem.fromJson(image))
          .toList(),
      localizacaoEvento: json['localizacaoEvento'],
    );
  }
}
