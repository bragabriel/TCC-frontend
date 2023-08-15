import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import '../model/artefato_model.dart';

class ImageHelper {
  static Widget buildCarrousel(List<Imagem>? listaDeImagens) {
    if (!listaDeImagens!.isEmpty) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = 16;
          final screenHeight = 9;
          final imageAspectRatio = screenWidth / screenHeight;
          return Container(
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: imageAspectRatio,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
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
}
