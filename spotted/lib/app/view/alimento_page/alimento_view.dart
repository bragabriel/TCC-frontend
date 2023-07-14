import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/controller/alimento_controller.dart';
import 'package:spotted/app/model/food_model.dart';
import 'package:spotted/app/repository/alimento_repository.dart';
import 'package:spotted/app/view/alimento_page/alimentoCadastrar_view.dart';

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
    try {
      final response = await Dio().get(
          'https://249e-45-172-242-15.ngrok-free.app/api/alimento?paginaAtual=1&qtdPorPagina=5');
      if (response.statusCode == 200) {
        final responseData = response.data['objetoRetorno']['content'];
        print(responseData);
        if (responseData != null && responseData is List<dynamic>) {
          setState(() {
            foodList = responseData.map((item) => Food.fromJson(item)).toList();
          });
        } else {
          print('Resposta inválida da API - conteúdo ausente');
        }
      } else {
        print('Erro na requisição da API');
      }
    } catch (e) {
      print('Erro ao acessar a API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alimentação"),
        actions: [
          IconButton(
            onPressed: () {
              //controller.start();
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: Stack(
        children: [
          GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
              foodList.length,
              (index) => Container(
                padding: const EdgeInsets.all(8),
                color: Colors.orange[100 + (index % 4) * 100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(foodList[index].titulo_artefato),
                    Text(foodList[index].descricao_artefato),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom:
                16, // Ajuste a posição vertical do botão conforme necessário
            right:
                16, // Ajuste a posição horizontal do botão conforme necessário
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => alimentoCadastrarPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
