import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotted/app/view/home_page/home_view.dart';
import '../../controller/job_controller.dart';
import '../../model/job_model.dart';
import '../../repository/job_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class PostsPageJobs extends StatefulWidget {
  @override
  State<PostsPageJobs> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPageJobs> {
  final controller = JobController();
  final JobsRepository jobsRepository = JobsRepository();

  // _success() {
  //   return Scaffold(
  //     body: FutureBuilder(
  //       future: jobsRepository.getJobs(),
  //       builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
  //         if (snapshot.hasData) {
  //           List<Post>? posts = snapshot.data;
  //           return ListView(
  //             children: posts!
  //                 .map(
  //                   (Post post) => ListTile(
  //                     title: Text(post.title),
  //                     subtitle: Text("${post.userId}"),
  //                   ),
  //                 )
  //                 .toList(),
  //           );
  //         } else {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //       },
  //     ),
  //   );
  // }

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
      // case HomeState.success:
      //   return _success();
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
        home: Scaffold(
      appBar: AppBar(
          title: const Text('Jobs'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )),
      body: ListView(children: [
        Image.network(
          job.imagem_job,
          width: 600,
          height: 240,
          fit: BoxFit.cover,
        ),
        titleSection,
        buttonSection,
        textSection
      ]),
    ));
  }
}

Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}

final String json = """
{
   "id_job": "001",
   "titulo_job": "Estágiario de Tecnologia",
   "descricao_job": "Precisamos de um estágiario do curso de sistemas de informação que tenha conhecimentos em C#, SQL, POO, e Clean code.",
   "imagem_job": "https://conteudo.imguol.com.br/c/noticias/a4/2022/03/29/clt-emprego-desemprego-carteira-de-trabalho-1648554135510_v2_4x3.jpg",
   "id_usuario": "1"
}
  """;
final Job job = Job.fromJson(jsonDecode(json));

Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildButtonColumn(Colors.green, Icons.whatsapp, 'WHATSAPP'),
    _buildButtonColumn(Colors.black, Icons.near_me, 'LOCALIZAÇÃO'),
    _buildButtonColumn(
        Colors.blueAccent, Icons.dataset_linked_rounded, 'NO LinkedIn'),
  ],
);

Widget textSection = const Padding(
  padding: EdgeInsets.all(32),
  child: Text(
    '',
    softWrap: true,
  ),
);

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                job.titulo_job,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              job.descricao_job,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

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
