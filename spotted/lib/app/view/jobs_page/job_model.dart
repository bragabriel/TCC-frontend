class JobModel {
  final int beneficio;
  final int id;
  final String title;
  final String salario;
  final String descricao;
  final String localizacao;
  final String contato;
  final String imagem;

  JobModel(
      {required this.beneficio,
      required this.id,
      required this.title,
      required this.salario,
      required this.descricao,
      required this.localizacao,
      required this.contato,
      required this.imagem});


  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      beneficio: json['beneficio'],
      id: json['id'],
      title: json['title'],
      salario: json['salario'],
      descricao: json['descricao'],
      localizacao: json['localizacao'],
      contato: json['contato'],
      imagem: json['imagem']
    );
  }
}
