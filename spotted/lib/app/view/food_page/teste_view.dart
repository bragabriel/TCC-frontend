import 'package:flutter/material.dart';
import '../../controller/teste_controller.dart';
import '../../repository/teste_repository.dart';
import 'post_model.dart';

class PostsPage extends StatefulWidget {

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  final controller = TesteController();
  final TesteRepository foodRepository = TesteRepository();

    _success(){
    return Scaffold(
   
          body: FutureBuilder(
            future: foodRepository.getPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
              if (snapshot.hasData) {
                List<Post>? posts = snapshot.data;
             
                /* return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Text('TEXTOOOOO'),
                  ), */
                
                return

                   ListView(
                  children: posts!
                      .map(
                        (Post post) => ListTile(
                          title: Text(post.title),
                          subtitle: Text("${post.userId}"),
                        ),
                      )
                      .toList(),
                );
                 /* ListView.separated(
                  
                  shrinkWrap: true, 
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('asd da lista $index'),
                      subtitle: Text(''),
                      trailing: const Icon(Icons.chevron_right),
                    );
                  }, 
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount:5
                  ),
                                    
                ],); */
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
            title: Text("Teste Consumindo API"),
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
              return stateManagement(controller.state.value);
            }),
    ));
  }
}
