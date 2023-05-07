import 'package:flutter/material.dart';
import 'package:spotted/app/view/home_page/home_view.dart';
import '../../controller/teste_controller.dart';
import '../../repository/teste_repository.dart';
import 'post_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
          '/detail': (context) => RouteTwo(
              image: '', name: '', description: '', preco: '', telefone: ''),
        });
  }
}

class PhotoItem {
  final String image;
  final String name;
  final String description;
  final String preco;
  final String telefone;
  PhotoItem(this.image, this.name, this.description, this.preco, this.telefone);
}

class RouteOne extends StatelessWidget {
  final List<PhotoItem> _items = [
    PhotoItem(
        "https://images.pexels.com/photos/867452/pexels-photo-867452.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Donouts",
        "Delicioso donouts de morango",
        "10,00",
        "19999138267"),
    PhotoItem(
        "https://images.pexels.com/photos/1055272/pexels-photo-1055272.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=10",
        "Cupcake",
        "Cupcake fofinho",
        "6,00",
        "19982930667"),
    PhotoItem(
        "https://images.pexels.com/photos/3309805/pexels-photo-3309805.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Bolacha",
        "Biscoito do Sheck",
        "7,00",
        "19999138267"),
    PhotoItem(
        "https://images.pexels.com/photos/4243302/pexels-photo-4243302.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Coxinha",
        "Coxinha goumert",
        "9,00",
        "19999138267"),
    PhotoItem(
        "https://images.pexels.com/photos/5742606/pexels-photo-5742606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Bolo",
        "Bolo caseiro",
        "5,00",
        "19999138267"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
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
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
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
                      image: _items[index].image,
                      name: _items[index].name,
                      description: _items[index].description,
                      preco: _items[index].preco,
                      telefone: _items[index].telefone),
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
  final String description;
  final String preco;
  final String telefone;

  RouteTwo(
      {Key? key,
      required this.image,
      required this.name,
      required this.description,
      required this.preco,
      required this.telefone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes 🍔🍩🥪'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 8,
              child: SizedBox(
                width: double.minPositive,
                child: Image(
                  image: NetworkImage(image),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                    )),
                Text("Descrição: $description",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0)),
                Text("Valor: $preco",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                    )),
                Text("Telefone: $telefone",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                    ))
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(37, 211, 101, 1),
          child: Icon(Icons.whatsapp),
          onPressed: () {
            abrirUrl(telefone);
          },
        ));
  }
}

void abrirUrl(String telefone) async {
  const whatsapp = 'https://api.whatsapp.com/send/?phone=55';
  const message = '&text=Ola+vi+o+anuncio+no+app+e+tenho+interesse';
  var url = whatsapp + telefone + message;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
