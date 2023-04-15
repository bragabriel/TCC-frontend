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

  _success() {
    return Scaffold(
      body: FutureBuilder(
        future: foodRepository.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
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

            return ListView(
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

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start();
        },
        child: Text('Tente novamente'),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _start() {
    return Container();
  }

  //Método para a troca de estado
  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.success:
        return _success();
      default:
        _start();
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
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Alimentação"),
              actions: [
                IconButton(
                  onPressed: () {
                    controller.start();
                  },
                  icon: const Icon(Icons.refresh_outlined),
                )
              ],
            ),
            //Reatividade dos nossos estados:
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.orange[100],
                  child: const Text("He'd have you all unravel at the"),
            
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.orange[200],
                  child: const Text('Heed not the rabble'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.orange[300],
                  child: const Text('Sound of screams but the'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.orange[400],
                  child: const Text('Who scream'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.orange[500],
                  child: const Text('Revolution is coming...'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.orange[600],
                  child: const Text('Revolution, they...'),
                ),
              ],
            )));
  }
}
