import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';

class ImageHelper {
  static uploadImagem(
    Response<dynamic>? idArtefato,
    imageFile,
  ) async {
    var client = http.Client();
    var uri = Uri.parse('$onlineApi/uploadImage/$idArtefato');
    var request = http.MultipartRequest("POST", uri);

    var multipartFile = http.MultipartFile(
        'files', imageFile.openRead(), await imageFile.length(),
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await client.send(request);
    client.close();
    response.stream.transform(utf8.decoder).listen((value) {
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
    var response = await client.send(request);
    client.close();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
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
