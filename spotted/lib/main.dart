import 'package:flutter/material.dart';
import 'package:spotted/app/view/alimento_page/alimento_view.dart';
import 'package:spotted/app/widget/app_widget.dart';

import 'app/view/alimento_page/postFood_view.dart';

main(){
  runApp(AppWidget());
}

Widget build(BuildContext context) {
 return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Alimentação',
    routes: <String, WidgetBuilder>{
        '/foodpage' : (BuildContext context) => new PostsPage(),
    },
 );}