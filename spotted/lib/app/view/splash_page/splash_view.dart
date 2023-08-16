import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/service/prefs_service.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({Key? key}) : super(key: key);

  @override createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{
  @override
  void initState(){
    super.initState();

    Future.wait([
      PrefsService.isAuth(),
      Future.delayed(Duration(seconds: 2)),
      ]).then((value) => value[0]
      ? Navigator.of(context).pushReplacementNamed('/home')
      : Navigator.of(context).pushReplacementNamed('/'));
  }

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.green.shade900,

      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white60,
        ))
    );
  }
}
