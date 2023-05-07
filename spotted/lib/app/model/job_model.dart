class Job {
  final int id_job;
  final String titulo_job;
  final String descricao_job;
  final String imagem_job;
  final String id_usuario;

  Job(
      {required this.id_job,
      required this.titulo_job,
      required this.descricao_job,
      required this.imagem_job,
      required this.id_usuario});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(id_job: json['id_job'],
    titulo_job: json['titulo_job'],
    descricao_job: json['descricao_job'],
    imagem_job: json['imagem_job'],
    id_usuario: json['id_usuario']);
  }
}
