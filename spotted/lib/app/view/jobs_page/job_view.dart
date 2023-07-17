import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotted/app/model/job_model.dart';


class JobPage extends StatefulWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  List<JobModel> jobList = [];

  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

  Future<void> _fetchFood() async {
    var dio = Dio(); // with default Options

    final response = await Dio().get('https://6d9c-45-172-242-31.sa.ngrok.io/api/comida?paginaAtual=1&qtdPorPagina=5');


    if(response.statusCode == 200){
      print('AQUI');
      print(response.data.runtimeType);
      print('deu bom');
    }else{
      print('deu ruim');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
      ),
      body: ListView.builder(
        itemCount: jobList.length,
        itemBuilder: (context, index) {
          final job = jobList[index];
          return ListTile(
            title: Text(job.cargo),
            subtitle: Text(job.descricao),
            leading: Image.network(job.imagem),
          );
        },
      ),
    );
  }
} 