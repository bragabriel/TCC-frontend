import 'package:flutter/material.dart';
import 'package:spotted/app/model/food_model.dart';
import '../../controller/food_controller.dart';
import '../../repository/food_repository.dart';

class FoodPage extends StatefulWidget {

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  final controller = FoodController();
  final FoodRepository foodRepository = FoodRepository();

    _success(){
    return Scaffold(
   
          body: FutureBuilder(
            future: foodRepository.getFood(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Food>> snapshot) {
              if (snapshot.hasData) {
                List<Food>? foodList = snapshot.data;
             
                return
                   ListView(
                  children: foodList!
                      .map(
                        (Food food) => ListTile(
                          title: Text(food.nomeComida),
                          subtitle: Text(food.tipoComida + 
                                          '\n Usuário vendendo está comida:' + food.idUsuario.toString()),
                        ),
                      )
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
  }

  _error(){
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start();
        },
      child: Text('Tente novamente'),),
    );
  }

  _loading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _start(){
    return Container();
  }

  //Método para a troca de estado
  stateManagement(HomeState state){
      switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default: _start();
    }
  }

  @override
  void initState() {
 
    super.initState();

    //Iniciou o Widget, chama o 'estado' .start()
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Comidas"),
            actions: [
              IconButton(
                onPressed:(){
                  controller.start();
                },
                icon: const Icon(Icons.refresh_outlined),
                )
            ],
          ),
          //Reatividade dos nossos estados:
          body: AnimatedBuilder(
            animation: controller.state, 
            builder: (context, child) {

              return _success();
              //return stateManagement(controller.state.value);
            }),
    ));
  }
}
