import 'artefato_model.dart';

class Emprego extends Artefato {
  final String? localizacaoEmprego;
  final String? requisitosEmprego;
  final num? salarioEmprego;
  final String? beneficiosEmprego;
  final String? contatoEmprego;
  final String? linkVagaEmprego;
  final String? empresaEmprego;
  final String? cidadeEmprego;
  final String? estadoEmprego;
  final String? experienciaEmprego;
  final String? tipoVagaEmprego;
  final String? presencialEmprego;

  Emprego({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required bool ativo,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required List<Imagem> listaImagens,
    required this.localizacaoEmprego,
    required this.requisitosEmprego,
    required this.salarioEmprego,
    required this.beneficiosEmprego,
    required this.contatoEmprego,
    required this.linkVagaEmprego,
    required this.empresaEmprego,
    required this.cidadeEmprego,
    required this.estadoEmprego,
    required this.experienciaEmprego,
    required this.tipoVagaEmprego,
    required this.presencialEmprego,
  }) : super(
          idArtefato: idArtefato,
          tituloArtefato: tituloArtefato,
          descricaoArtefato: descricaoArtefato,
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

      ativo: json['ativo'],
      dataCadastro: json['dataCadastro'],
      dataAtualizacao: json[
          'dataAtualizacao'], // Remoção da conversão, mantendo o valor como String?
      idUsuario: json['idUsuario'],
      listaImagens: (json['listaImagens'] as List<dynamic>)
          .map((image) => Imagem.fromJson(image))
          .toList(),
      localizacaoEmprego: json['localizacaoEmprego'],
      requisitosEmprego: json['requisitosEmprego'],
      salarioEmprego: json['salarioEmprego'],
      beneficiosEmprego: json['beneficiosEmprego'],
      contatoEmprego: json['contatoEmprego'],
      linkVagaEmprego: json['linkVagaEmprego'],
      empresaEmprego: json['empresaEmprego'],
      cidadeEmprego: json['cidadeEmprego'],
      estadoEmprego: json['estadoEmprego'],
      experienciaEmprego: json['experienciaEmprego'],
      tipoVagaEmprego: json['tipoVagaEmprego'],
      presencialEmprego: json['presencialEmprego'],
    );
  }
}
