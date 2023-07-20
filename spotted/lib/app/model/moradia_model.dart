import 'artefato_model.dart';

class Emprego extends Artefato {
  final String? localizacaoMoradia;
  final num? qtdMoradoresPermitidoMoradia;
  final num? qtdMoradoresAtuaisMoradia;
  final num? precoAluguelTotalMoradia;
  final num? precoAluguelPorPessoaMoradia;
  final String? vagaGaragemMoradia;
  final String? animaisEstimacaoMoradia;				

  Emprego({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required String tipoArtefato,
    required bool ativo,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required List<Imagem> listaImagens,
    required this.localizacaoMoradia,
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
          tipoArtefato: tipoArtefato,
          ativo: ativo,
          dataCadastro: dataCadastro,
          dataAtualizacao: dataAtualizacao,
          idUsuario: idUsuario,
          listaImagens: listaImagens,
        );

  factory Emprego.fromJson(Map<String, dynamic> json) {
    return Emprego(
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
      localizacaoMoradia: json['localizacaoMoradia'],
      qtdMoradoresPermitidoMoradia: json['qtdMoradoresPermitidoMoradia'],
      qtdMoradoresAtuaisMoradia: json['qtdMoradoresAtuaisMoradia'],
      precoAluguelTotalMoradia: json['precoAluguelTotalMoradia'],
      precoAluguelPorPessoaMoradia: json['precoAluguelPorPessoaMoradia'],
      vagaGaragemMoradia: json['vagaGaragemMoradia'],
      animaisEstimacaoMoradia: json['animaisEstimacaoMoradia'],					
    );
  }
}
