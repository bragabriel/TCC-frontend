import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/widget/app_widget.dart';
import 'package:spotted/service/change_notifier.dart';

import 'app/view/alimento_page/alimento_view.dart';

main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      
      child: const AppWidget(),
    ),
  );
}

Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
 return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Alimentação',
    routes: <String, WidgetBuilder>{
        '/foodpage' : (BuildContext context) => const AlimentoPage(),
    },
 );}
