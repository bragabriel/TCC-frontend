class Usuario {
  final int idUsuario;
  String nomeUsuario;
  String sobrenomeUsuario;
  String emailUsuario;
  String? senhaUsuario;
  String? telefoneUsuario;
  String? url;
  String? fileName;
  List<dynamic>? listaArtefatosReponse;

  Usuario.empty()
      : idUsuario = 0,
        nomeUsuario = '',
        sobrenomeUsuario = '',
        emailUsuario = '',
        senhaUsuario = '',
        telefoneUsuario = '',
        url = '',
        fileName = '',
        listaArtefatosReponse = List.empty();

  Usuario(
      {required this.idUsuario,
      required this.nomeUsuario,
      required this.sobrenomeUsuario,
      required this.emailUsuario,
      this.senhaUsuario,
      this.telefoneUsuario,
      this.url,
      this.fileName,
      this.listaArtefatosReponse});

  Usuario copy({
    int? idUsuario,
    String? nomeUsuario,
    String? sobrenomeUsuario,
    String? emailUsuario,
    String? senhaUsuario,
    String? telefoneUsuario,
    String? descricaoUsuario,
    String? url,
    String? fileName,
    List<dynamic>? listaArtefatosReponse,
  }) =>
      Usuario(
          idUsuario: idUsuario ?? this.idUsuario,
          nomeUsuario: nomeUsuario ?? this.nomeUsuario,
          sobrenomeUsuario: sobrenomeUsuario ?? this.sobrenomeUsuario,
          emailUsuario: emailUsuario ?? this.emailUsuario,
          senhaUsuario: senhaUsuario ?? this.senhaUsuario,
          telefoneUsuario: telefoneUsuario ?? this.telefoneUsuario,
          url: url ?? this.url,
          fileName: fileName ?? this.fileName,
          listaArtefatosReponse:
              listaArtefatosReponse ?? this.listaArtefatosReponse);

  static Usuario fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json['idUsuario'],
        nomeUsuario: json['nomeUsuario'],
        sobrenomeUsuario: json['sobrenomeUsuario'],
        emailUsuario: json['emailUsuario'],
        senhaUsuario: json['senhaUsuario'] as String? ?? "",
        telefoneUsuario: json['telefoneUsuario'],
        fileName: json['fileName'] as String? ?? "",
        url: json['url'] as String? ?? "",
        listaArtefatosReponse: json['listaArtefatosReponse'],
      );

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'nomeUsuario': nomeUsuario,
        'sobrenomeUsuario': sobrenomeUsuario,
        'emailUsuario': emailUsuario,
        'senhaUsuario': senhaUsuario,
        'telefoneUsuario': telefoneUsuario,
        'url': url,
        'fileName': fileName,
        'listaArtefatosReponse': listaArtefatosReponse
      };
}
