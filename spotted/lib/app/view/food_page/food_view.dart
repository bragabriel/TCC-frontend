import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/model/food_model.dart';


class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<Food> foodList = [];

  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

  Future<void> _fetchFood() async {
    var dio = Dio(); // with default Options

    final response = await Dio().get('https://6d9c-45-172-242-31.sa.ngrok.io/api/comida?paginaAtual=1&qtdPorPagina=5');


    if(response.statusCode == 200){
      print('AQUI');
      print(response.data.runtimeType);

      print('deu bom');
    }else{
      print('deu ruim');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
      ),
      body: ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          final food = foodList[index];
          return ListTile(
            title: Text(food.titulo_comida),
            subtitle: Text(food.descricao_comida),
            leading: Image.network(food.imagem_comida),
          );
        },
      ),
    );
  }
} 