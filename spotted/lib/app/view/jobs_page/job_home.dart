import 'package:flutter/material.dart';
import 'package:spotted/app/view/jobs_page/postjobs_view.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'dart:convert';
import '../../model/job_model.dart';
import '../home_page/home_view.dart';

class JobHome extends StatefulWidget {
  @override
  _JobHomeState createState() => _JobHomeState();
}

var json = """
{
   "id_job": "001",
   "titulo_job": "Estágiario de Tecnologia",
   "descricao_job": "Precisamos de um estágiario do curso de sistemas de informação que tenha conhecimentos em C#, SQL, POO, e Clean code.",
   "imagem_job": "https://conteudo.imguol.com.br/c/noticias/a4/2022/03/29/clt-emprego-desemprego-carteira-de-trabalho-1648554135510_v2_4x3.jpg",
   "id_usuario": "1",
   "contato": "19999138267",
   "localizacao": "mogi guacu"
}
  """;

class _JobHomeState extends State<JobHome> {
  var job = Job.fromJson(jsonDecode(json));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Empregos"),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )),
      body: JobHome(),
    );
  }

  final List<Map> _jobs = List.generate(
      10,
      (index) => {
            "id": index,
            "title": 'Tecnico de TI',
            "descricao": 'Entre 2 e 3 ano do curso de Sistemas de Informação',
            "imagem":
                'https://blog.fecap.br/wp-content/uploads/Fecap-programador.jpg'
          }).toList();

  Widget JobHome() {
    return Container(
      child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: _jobs.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PostsPageJobs(); //MUDAR AQUI
                    },
                  ),
                );
              },
              child: GridTile(
                key: ValueKey(_jobs[index]['id']),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    _jobs[index]['title'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle:  Text(_jobs[index]['descricao']),
                  trailing: const Icon(Icons.shopping_cart),
                ),
                // child: Image.network(
                //   _jobs[index]['imagem'],
                //   fit: BoxFit.cover,
                // ),
                 child: Image.asset('assets/images/teste.png',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}

