import 'package:flutter/material.dart';
import 'package:spotted/app/view/jobs_page/postjobs_view.dart';
import 'dart:convert';
import '../../model/job_model.dart';
import '../home_page/home_view.dart';

class JobHome extends StatefulWidget {
  @override
  _JobHomeState createState() => _JobHomeState();
}

var json = """
{
"beneficio": "VA, VT, e VR",
"id": 1,
"cargo":"Estágiario",
"area": "Tecnologia",
"salario":"1200,00",
"descricao":"Estágiario do curso de sistemas de informação que tenha conhecimentos em C#, SQL, POO, e Clean code.",
"localizacao":"Campinas SP",
"contato":"19999138267",
"imagem":"https://conteudo.imguol.com.br/c/noticias/a4/2022/03/29/clt-emprego-desemprego-carteira-de-trabalho-1648554135510_v2_4x3.jpg",
"link_vaga":"https://www.linkedin.com/jobs/view/3636181640/?alternateChannel=search&refId=WwLT0zKtccDjHQHorcnWzA%3D%3D&trackingId=I7a2sLD7xQ%2FKn8scd3AxhA%3D%3D"
}
  """;

var job = JobModel.fromJson(jsonDecode(json));

class _JobHomeState extends State<JobHome> {
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
      1,
      (index) => {
            "id": index,
            "cargo": job.cargo,
            "area": job.area,
            "imagem": job.imagem
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
                    _jobs[index]['cargo'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_jobs[index]['area']),
                ),
                // child: Image.network(
                //   _jobs[index]['imagem'],
                //   fit: BoxFit.cover,
                // ),
                child: Image.asset(
                  'assets/images/jobs.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
