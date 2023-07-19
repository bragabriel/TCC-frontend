import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotted/app/view/home_page/home_view.dart';
import '../../model/job_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PostsPageJobs extends StatefulWidget {
  @override
  State<PostsPageJobs> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPageJobs> {
  // final controller = JobController();
  // final JobRepository jobsRepository = JobRepository();

  // _success() {
  //   return Scaffold(
  //     body: FutureBuilder(
  //       future: jobsRepository.getJobModels(),
  //       builder: (BuildContext context, AsyncSnapshot<List<JobModel>> snapshot) {
  //         if (snapshot.hasData) {
  //           List<JobModel>? posts = snapshot.data;
  //           return ListView(
  //             children: posts!
  //                 .map(
  //                   (JobModel post) => ListTile(
  //                     title: Text(post.cargo),
  //                     subtitle: Text("${post.id}"),
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

  // _error() {
  //   return Center(
  //     child: ElevatedButton(
  //       onPressed: () {
  //         controller.start();
  //       },
  //       child: Text('Tente novamente'),
  //     ),
  //   );
  // }

  // _loading() {
  //   return Center(
  //     child: CircularProgressIndicator(),
  //   );
  // }

  // _start() {
  //   return Container();
  // }

  // //Método para a troca de estado
  // stateManagement(HomeState state) {
  //   switch (state) {
  //     case HomeState.start:
  //       return _start();
  //     case HomeState.loading:
  //       return _loading();
  //     case HomeState.error:
  //       return _error();
  //     // case HomeState.success:
  //     //   return _success();
  //     default:
  //       _start();
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   //Iniciou o Widget, chama o 'estado' .start()
  //   controller.start();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )),
      body: ListView(children: [
        Image.asset(
          'assets/images/jobs.jpg',
          width: 600,
          height: 240,
          fit: BoxFit.cover,
        ),
        titleSection,
        buttonSection
      ]),
      
    ));
  }
}


Column _botaoNovo(Color color, IconData icon, String textBase, String dado) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      IconButton(
        icon: Icon(icon, color: color, size: 50),
        onPressed: () => abrirUrl(textBase + dado),
        alignment: Alignment.topCenter,
      ),
    ],
    
  );
}

final String json = """
{
"beneficio": "VA, VT, e VR",
"id": 1,
"cargo":"Estágiario",
"area": "Tecnologia",
"salario":"1180,00",
"descricao":"Estágiario do curso de sistemas de informação que tenha conhecimentos em C#, SQL, POO, e Clean code.",
"localizacao":"Campinas SP",
"contato":"19999138267",
"imagem":"https://conteudo.imguol.com.br/c/noticias/a4/1822/03/29/clt-emprego-desemprego-carteira-de-trabalho-1648554135510_v2_4x3.jpg",
"link_vaga":"https://www.linkedin.com/jobs/view/3636181640/?alternateChannel=search&refId=WwLT0zKtccDjHQHorcnWzA%3D%3D&trackingId=I7a2sLD7xQ%2FKn8scd3AxhA%3D%3D"
}
  """;
final JobModel job = JobModel.fromJson(jsonDecode(json));

Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
   // _botaoNovo(Colors.green, Icons.whatsapp,
      //  'https://api.whatsapp.com/send/?phone=55', job.contato),
    _botaoNovo(Color.fromARGB(255, 0, 170, 255), Icons.near_me,
        'https://www.google.com/maps/search/', job.localizacao),
    _botaoNovo(Colors.black, Icons.link, '', job.link_vaga),
  ],
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
                "${job.cargo} – ${job.area} \n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
            Text(
              "Descrição: ${job.descricao} \n",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Text(
              "Benefícios: ${job.beneficio} \n",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Text(
              "Salário:R\$ ${job.salario} \n",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    ],
  ),
);

void abrirUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw '[LOG] NAO DEU PARA RODAR ESSA PORRA AQUI: $url';
  }
}
