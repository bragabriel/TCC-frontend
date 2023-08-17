import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/constants.dart';

upload(int idArtefato) async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);

    // Create a new http.Client instance
    var client = http.Client();

    // string to uri
    var uri = Uri.parse('$onlineApi/uploadImage/$idArtefato');

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = http.MultipartFile('files', imageFile.openRead(), await imageFile.length(),
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await client.send(request);

    // Close the client after the request is complete
    client.close();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}

  
// class ImageUploader {
//   static Future<void> uploadImage(BuildContext context, int idArtefato) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       File imageFile = File(pickedFile.path);

//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('$onlineApi/uploadImage/$idArtefato'),
//       );

//       var file = await http.MultipartFile.fromPath(
//         'image',
//         imageFile.path,
//         contentType: MediaType('image', 'jpeg'),
//       );

//       request.files.add(file);

//       var response = await request.send();

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Imagem enviada com sucesso!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erro ao enviar imagem.')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Nenhuma imagem selecionada.')),
//       );
//     }
//   }
// }


