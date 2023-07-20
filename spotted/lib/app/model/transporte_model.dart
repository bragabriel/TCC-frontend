import 'artefato_model.dart';

class Transporte extends Artefato {
  final String? informacoesVeiculoTransporte;
  final String? informacoesCondutorTransporte;
  final num? qtdAssentosTotalTransporte;
  final num? qtdAssentosPreenchidosTransporte;
  final String? cidadeTransporte;
  final String? periodoTransporte;	

  Transporte({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required String tipoArtefato,
    required bool ativo,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required List<Imagem> listaImagens,
    required this.informacoesVeiculoTransporte,
    required this.informacoesCondutorTransporte,
    required this.qtdAssentosTotalTransporte,
    required this.qtdAssentosPreenchidosTransporte,
    required this.cidadeTransporte,
    required this.periodoTransporte,	
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

  factory Transporte.fromJson(Map<String, dynamic> json) {
    return Transporte(
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
      informacoesVeiculoTransporte: json['informacoesVeiculoTransporte'],
      informacoesCondutorTransporte: json['informacoesCondutorTransporte'],
      qtdAssentosTotalTransporte: json['qtdAssentosTotalTransporte'],
      qtdAssentosPreenchidosTransporte: json['qtdAssentosPreenchidosTransporte'],
      cidadeTransporte: json['cidadeTransporte'],
      periodoTransporte: json['periodoTransporte'],
    );
  }
}
