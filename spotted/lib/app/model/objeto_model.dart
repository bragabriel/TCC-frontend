import 'artefato_model.dart';

class Objeto extends Artefato {
  final String? localizacaoAchadoObjeto;
  final String? localizacaoAtualObjeto;

  Objeto({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required bool ativo,
    required String tipoArtefato,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required List<Imagem> listaImagens,
    required this.localizacaoAchadoObjeto,
    required this.localizacaoAtualObjeto,
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

  factory Objeto.fromJson(Map<String, dynamic> json) {
    return Objeto(
      idArtefato: json['idArtefato'],
      tituloArtefato: json['tituloArtefato'],
      descricaoArtefato: json['descricaoArtefato'],

      ativo: json['ativo'],
      tipoArtefato: json['tipoArtefato'],
      dataCadastro: json['dataCadastro'],
      dataAtualizacao: json[
          'dataAtualizacao'], // Remoção da conversão, mantendo o valor como String?
      idUsuario: json['idUsuario'],
      listaImagens: (json['listaImagens'] as List<dynamic>)
          .map((image) => Imagem.fromJson(image))
          .toList(),
      localizacaoAchadoObjeto: json['localizacaoAchadoObjeto'],
      localizacaoAtualObjeto: json['localizacaoAtualObjeto'],
    );
  }
}
