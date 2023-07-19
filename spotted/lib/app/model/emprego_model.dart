import 'artefato_model.dart';

class Emprego extends Artefato {
  final String localizacaoEmprego;
  final String requisitosEmprego;
  final double salarioEmprego;
  final String beneficiosEmprego;
  final String contatoEmprego;
  final String linkVagaEmprego;

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
    required this.localizacaoEmprego,
    required this.requisitosEmprego,
    required this.salarioEmprego,
    required this.beneficiosEmprego,
    required this.contatoEmprego,
    required this.linkVagaEmprego,
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
      localizacaoEmprego: json['localizacaoEmprego'],
      requisitosEmprego: json['requisitosEmprego'],
      salarioEmprego: json['salarioEmprego'],
      beneficiosEmprego: json['beneficiosEmprego'],
      contatoEmprego: json['contatoEmprego'],
      linkVagaEmprego: json['linkVagaEmprego'],
    );
  }
}
