import 'package:flutter/material.dart';
import 'package:spotted/app/model/alimento_model.dart';
import 'package:spotted/app/view/home_page/home_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AlimentoDetalheView extends StatefulWidget {
  @override
  State<AlimentoDetalheView> createState() => AlimentoDetalheState();

  final Alimento filteredFoodList;
  const AlimentoDetalheView(this.filteredFoodList);
}

class AlimentoDetalheState extends State<AlimentoDetalheView> {
  @override
  Widget build(BuildContext context) {
    Alimento alimento = widget.filteredFoodList;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: ListView(
          // children: [
          // Image.network(
          //   alimento.listaImagens?[0].url as String,
          //   width: 600,
          //   height: 240,
          //   fit: BoxFit.cover,
          // ),
          children: [
            Image.asset(
              'assets/images/jobs.jpg',
              fit: BoxFit.cover,
            ),
            DetalhesAlimento(alimento: alimento),
            BotaoAlimento(alimento: alimento),
          ],
        ),
      ),
    );
  }
}

class BotaoAlimento extends StatelessWidget {
  final Alimento alimento;

  BotaoAlimento({required this.alimento});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BotaoNovo(
            Colors.blue,
            Icons.message,
            'https://api.whatsapp.com/send/?phone=55',
            "19999138267") //alimento.contato)
      ],
    );
  }
}

class DetalhesAlimento extends StatelessWidget {
  final Alimento alimento;

  DetalhesAlimento({required this.alimento});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        children: [
          Text(
            "${alimento.tituloArtefato} – ${alimento.saborAlimento} \n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          Text(
            "${alimento.descricaoArtefato} \n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Text(
            "${alimento.saborAlimento} \n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Text(
            "${alimento.unidadeAlimento} \n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Text(
            "R\$ ${alimento.precoAlimento?.toStringAsFixed(2) ?? '0.00'} \n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),

        ],
      ),
    );
  }
}

void AbrirURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Não foi possível abrir $url';
  }
}

Column BotaoNovo(Color color, IconData icon, String textBase, String dado) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      IconButton(
        icon: Icon(icon, color: color, size: 50),
        onPressed: () => AbrirURL(textBase + dado),
      ),
    ],
  );
}