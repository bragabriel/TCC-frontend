import 'package:flutter/material.dart';
import 'package:spotted/app/view/home_page/home_view.dart';
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
    const title = 'Alimentos';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => RouteOne(),
          '/detail': (context) => RouteTwo(image: '', name: ''),
        });
  }
}

class PhotoItem {
  final String image;
  final String name;
  final String description;
  final String preco;
  PhotoItem(this.image, this.name, this.description, this.preco);
}

class RouteOne extends StatelessWidget {
  final List<PhotoItem> _items = [
    PhotoItem(
        "https://images.pexels.com/photos/867452/pexels-photo-867452.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Donouts",
        "Delicioso donouts de morango",
        "10,00"),
    PhotoItem(
        "https://images.pexels.com/photos/1055272/pexels-photo-1055272.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=10",
        "Cupcake",
        "Cupcake fofinho",
        "6,00"),
    PhotoItem(
        "https://images.pexels.com/photos/3309805/pexels-photo-3309805.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Bolacha",
        "Biscoito do Sheck",
        "7,00"),
    PhotoItem(
        "https://images.pexels.com/photos/4243302/pexels-photo-4243302.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Coxinha",
        "Coxinha goumert",
        "9,00"),
    PhotoItem(
        "https://images.pexels.com/photos/5742606/pexels-photo-5742606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Bolo",
        "Bolo caseiro",
        "5,00"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Alimentos 😋'),
          leading: BackButton(
            onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          )),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 3,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RouteTwo(
                      image: _items[index].image, name: _items[index].name),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_items[index].image),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RouteTwo extends StatelessWidget {
  final String image;
  final String name;

  RouteTwo({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes 🍔🍩🥪'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              child: Image(
                image: NetworkImage(image),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
