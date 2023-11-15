import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spotted/app/widget/app_widget.dart';
import 'package:spotted/service/user_provider.dart';
import 'app/view/alimento_page/alimento_view.dart';

main() {
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
    statusBarIconBrightness: Brightness.dark,
  ));
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Alimentação',
    routes: <String, WidgetBuilder>{
      '/foodpage': (BuildContext context) => const AlimentoPage(),
    },
  );
}
