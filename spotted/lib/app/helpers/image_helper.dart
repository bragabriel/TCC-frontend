import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';

class ImageHelper {
  static Widget buildCarrousel(List<Imagem>? listaDeImagens) {
    if (listaDeImagens?.length == 1) {
      // Se houver apenas uma imagem, exibe-a diretamente
      return Image.network(
        listaDeImagens![0].url,
        fit: BoxFit.cover,
      );
    } else if (listaDeImagens!.isNotEmpty) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          const screenWidth = 16;
          const screenHeight = 9;
          const imageAspectRatio = screenWidth / screenHeight;
          return SizedBox(
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: imageAspectRatio,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInExpo,
                pauseAutoPlayOnTouch: true,
              ),
              items: listaDeImagens.map((imagemPath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      imagemPath.url,
                      fit: BoxFit.cover,
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Image.asset('assets/images/imagem.png'),
      );
    }
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
    print("\n\n\n\nid artefato::::::::::::");
    print(idArtefato);
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
