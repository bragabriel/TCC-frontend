import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:spotted/app/model/artefato_model.dart';
import 'dart:convert';
import '../constants/constants.dart';

class ImageHelper {
  static Widget loadImage(List<Imagem>? listaDeImagens) {
    return Image.network(
      listaDeImagens![0].url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        if (error is NetworkImageLoadException) {
          return Image.asset('assets/images/imagem.png');
        }
        return Center(
          child: Text('Error loading image'),
        );
      },
    );
  }

  static uploadImagem(
    Response<dynamic>? idArtefato,
    imageFile,
  ) async {
    print("\n\n\n\nid artefato::::::::::::");
    var client = http.Client();
    var uri = Uri.parse('$onlineApi/uploadImage/$idArtefato');
    var request = http.MultipartRequest("POST", uri);

    var multipartFile = http.MultipartFile(
        'files', imageFile.openRead(), await imageFile.length(),
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    print("ta no upload de imagens");
    print(multipartFile);
    print(request);

    var response = await client.send(request);
    client.close();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  static updateImagem(
    int idArtefato,
    imageFile,
  ) async {
    var client = http.Client();
    var uri = Uri.parse('$onlineApi/uploadImage/$idArtefato');
    var request = http.MultipartRequest("POST", uri);

    var multipartFile = http.MultipartFile(
        'files', imageFile.openRead(), await imageFile.length(),
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    print("ta no upload de imagens");
    print(multipartFile);
    print(request);

    var response = await client.send(request);
    client.close();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  static Future<File?> selecionarImagem() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
