import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/view/alimento_page/alimento_view.dart';
import 'package:spotted/app/widget/app_widget.dart';
import 'package:spotted/service/change_notifier.dart';

main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      
      child: AppWidget(),
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
        '/foodpage' : (BuildContext context) => new AlimentoPage(),
    },
 );}
