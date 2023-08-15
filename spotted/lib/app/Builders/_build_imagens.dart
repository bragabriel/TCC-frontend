// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../model/artefato_model.dart';

// class BuildImagens {  
//   Widget _buildImagens(List<Imagem>? listaDeImagens) {
//     if (!listaDeImagens!.isEmpty) {
//       final imageAspectRatio = 2 / 3;
//       return Scaffold(
//         body: AspectRatio(
//           aspectRatio: imageAspectRatio,
//           child: Container(
//             width: double.infinity,
//             child: CarouselSlider(
//               options: CarouselOptions(
//                 height: double.infinity,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 autoPlayInterval: Duration(seconds: 3),
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 autoPlayCurve: Curves.easeInExpo,
//                 pauseAutoPlayOnTouch: true,
//               ),
//               items: listaDeImagens.map((imagemPath) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Image.network(
//                       imagemPath.url,
//                       fit: BoxFit.cover,
//                     );
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       );
//     } else {
//       return Center(
//         child: Image.asset('assets/images/imagem.png'),
//       );
//     }
//   }
// }


