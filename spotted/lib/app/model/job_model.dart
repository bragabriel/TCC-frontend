class JobModel {
  final String beneficio;
  final int id;
  final String cargo;
  final String salario;
  final String descricao;
  final String localizacao;
  final String contato;
  final String imagem;
  final String link_vaga;
  final String area;

  JobModel(
      {required this.beneficio,
      required this.id,
      required this.cargo,
      required this.salario,
      required this.descricao,
      required this.localizacao,
      required this.contato,
      required this.imagem,
      required this.link_vaga,
      required this.area});

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
        beneficio: json['beneficio'],
        id: json['id'],
        cargo: json['cargo'],
        salario: json['salario'],
        descricao: json['descricao'],
        localizacao: json['localizacao'],
        contato: json['contato'],
        imagem: json['imagem'],
        link_vaga: json['link_vaga'],
        area: json['area']);
  }
}
