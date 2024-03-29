import 'artefato_model.dart';

class Moradia extends Artefato {
  final String? estadoMoradia;
  final String? cidadeMoradia;
  final String? bairroMoradia;
  final String? cepMoradia;
  final num? qtdMoradoresPermitidoMoradia;
  final num? qtdMoradoresAtuaisMoradia;
  final num? precoAluguelTotalMoradia;
  final num? precoAluguelPorPessoaMoradia;
  final String? vagaGaragemMoradia;
  final String? animaisEstimacaoMoradia;

  Moradia({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required bool ativo,
    required String tipoArtefato,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required List<Imagem> listaImagens,
    required this.cidadeMoradia,
    required this.bairroMoradia,
    required this.estadoMoradia,
    required this.cepMoradia,
    required this.qtdMoradoresPermitidoMoradia,
    required this.qtdMoradoresAtuaisMoradia,
    required this.precoAluguelTotalMoradia,
    required this.precoAluguelPorPessoaMoradia,
    required this.vagaGaragemMoradia,
    required this.animaisEstimacaoMoradia,
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

  factory Moradia.fromJson(Map<String, dynamic> json) {
    return Moradia(
      idArtefato: json['idArtefato'],
      tituloArtefato: json['tituloArtefato'],
      descricaoArtefato: json['descricaoArtefato'],

      ativo: json['ativo'],
      tipoArtefato: json['tipoArtefato'],
      dataCadastro: json['dataCadastro'],
      dataAtualizacao: json[
          'dataAtualizacao'],
      idUsuario: json['idUsuario'],
      listaImagens: (json['listaImagens'] as List<dynamic>)
          .map((image) => Imagem.fromJson(image))
          .toList(),
      estadoMoradia: json['estadoMoradia'],
      cidadeMoradia: json['cidadeMoradia'],
      bairroMoradia: json['bairroMoradia'],
      cepMoradia: json['cepMoradia'],
      qtdMoradoresPermitidoMoradia: json['qtdMoradoresPermitidoMoradia'],
      qtdMoradoresAtuaisMoradia: json['qtdMoradoresAtuaisMoradia'],
      precoAluguelTotalMoradia: json['precoAluguelTotalMoradia'],
      precoAluguelPorPessoaMoradia: json['precoAluguelPorPessoaMoradia'],
      vagaGaragemMoradia: json['vagaGaragemMoradia'],
      animaisEstimacaoMoradia: json['animaisEstimacaoMoradia'],
    );
  }
}
