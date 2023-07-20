import 'artefato_model.dart';

class Usuario extends Artefato {
  String nomeUsuario;
  String sobrenomeUsuario;
  String emailUsuario;
  String senhaUsuario;
  String telefoneUsuario;
  String dataNascimento;
  String url;
  String? fileName;
  String? descricaoUsuario;

  // Constructor
  Usuario({
    required int idArtefato,
    required String tituloArtefato,
    required String descricaoArtefato,
    required String tipoArtefato,
    required bool ativo,
    required String dataCadastro,
    required String? dataAtualizacao,
    required int idUsuario,
    required List<Imagem>? listaImagens,
    required this.nomeUsuario,
    required this.sobrenomeUsuario,
    required this.emailUsuario,
    required this.senhaUsuario,
    required this.telefoneUsuario,
    required this.dataNascimento,
    required this.url,
    required this.fileName,
    required this.descricaoUsuario,
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

  Usuario copy({
    int? idUsuario,
    String? nomeUsuario,
    String? sobrenomeUsuario,
    String? emailUsuario,
    String? senhaUsuario,
    String? telefoneUsuario,
    String? descricaoUsuario,
    String? imagePath,
  }) =>
      Usuario(
        idArtefato: idArtefato,
        tituloArtefato: tituloArtefato,
        descricaoArtefato: descricaoArtefato,
        tipoArtefato: tipoArtefato,
        ativo: ativo,
        dataCadastro: dataCadastro,
        dataAtualizacao: dataAtualizacao,
        listaImagens: listaImagens,
        idUsuario: idUsuario ?? this.idUsuario,
        nomeUsuario: nomeUsuario ?? this.nomeUsuario,
        sobrenomeUsuario: sobrenomeUsuario ?? this.sobrenomeUsuario,
        emailUsuario: emailUsuario ?? this.emailUsuario,
        senhaUsuario: senhaUsuario ?? this.senhaUsuario,
        telefoneUsuario: telefoneUsuario ?? this.telefoneUsuario,
        descricaoUsuario: descricaoUsuario ?? this.descricaoUsuario,
        dataNascimento: dataNascimento,
        fileName: fileName,
        url: imagePath ?? '',
      );

  static Usuario fromJson(Map<String, dynamic> json) => Usuario(
        idArtefato: json['idArtefato'],
        tituloArtefato: json['tituloArtefato'],
        descricaoArtefato: json['descricaoArtefato'],
        tipoArtefato: json['tipoArtefato'],
        ativo: json['ativo'],
        dataCadastro: json['dataCadastro'],
        dataAtualizacao: json[
            'dataAtualizacao'], // Remoção da conversão, mantendo o valor como String?
        idUsuario: json['idUsuario'],
        listaImagens: (json['listaImagens'] as List<dynamic>)
            .map((image) => Imagem.fromJson(image))
            .toList(),

        nomeUsuario: json['nomeUsuario'],
        sobrenomeUsuario: json['sobrenomeUsuario'],
        emailUsuario: json['emailUsuario'],
        senhaUsuario: json['senhaUsuario'],
        descricaoUsuario: json['descricaoUsuario'],
        telefoneUsuario: json['telefoneUsuario'],
        dataNascimento: json['dataNascimento'],
        fileName: json['fileName'],
        url: json['imagePath'],
      );

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'nomeUsuario': nomeUsuario,
        'sobrenomeUsuario': sobrenomeUsuario,
        'emailUsuario': emailUsuario,
        'senhaUsuario': senhaUsuario,
        'descricaoUsuario': descricaoUsuario,
        'telefoneUsuario': telefoneUsuario,
        'imagePath': url,
      };
}