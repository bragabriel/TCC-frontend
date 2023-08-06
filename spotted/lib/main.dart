import 'package:flutter/material.dart';
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
 return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Alimentação',
    routes: <String, WidgetBuilder>{
        '/foodpage' : (BuildContext context) => new AlimentoPage(),
    },
 );}