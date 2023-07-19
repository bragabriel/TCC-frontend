import 'package:flutter/material.dart';
import 'package:spotted/app/repository/emprego_repository.dart';
import 'package:spotted/app/model/emprego_model.dart';

import 'empregoCadastrar_view.dart';

class EmpregoPage extends StatefulWidget {
  const EmpregoPage({Key? key}) : super(key: key);

  @override
  _EmpregoPageState createState() => _EmpregoPageState();
}

class _EmpregoPageState extends State<EmpregoPage> {
  List<Emprego> empregoList = [];
  List<Emprego> filteredEmpregoList = [];
  List<String> selectedBenefits = [];
  String selectedCity = '';
  double? minSalary;
  double? maxSalary;

  @override
  void initState() {
    super.initState();
    _fetchEmprego();
  }

  Future<void> _fetchEmprego() async {
    try {
      final empregoList = await EmpregoRepository().getAllEmpregos();
      setState(() {
        this.empregoList = empregoList;
        filteredEmpregoList = empregoList;
      });
    } catch (e) {
      print('Erro ao obter a lista de empregos: $e');
    }
  }

  /* List<String> _getAllBenefits() {
    return empregoList
        .expand((emprego) => emprego.beneficiosEmprego?.split(',') ?? [])
        .map((benefit) => benefit.trim())
        .toSet()
        .toList();
  } */

  List<String> _getCitiesList() {
    return empregoList.map((emprego) => emprego.localizacaoEmprego).toSet().toList();
  }

  void _filterEmpregoList() {
    setState(() {
      filteredEmpregoList = empregoList.where((emprego) {
        final meetsBenefitCriteria = selectedBenefits.isEmpty ||
            emprego.beneficiosEmprego != null &&
                selectedBenefits.any(
                  (benefit) => emprego.beneficiosEmprego!.toLowerCase().contains(benefit.toLowerCase()),
                );

        final meetsCityCriteria =
            selectedCity.isEmpty || emprego.localizacaoEmprego.toLowerCase() == selectedCity.toLowerCase();

        final meetsSalaryCriteria =
            (minSalary == null || emprego.salarioEmprego! >= minSalary!) &&
                (maxSalary == null || emprego.salarioEmprego! <= maxSalary!);

        return meetsBenefitCriteria && meetsCityCriteria && meetsSalaryCriteria;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Empregos"),
        actions: [
          IconButton(
            onPressed: () {
              _fetchEmprego();
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: _buildFiltersAndList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmpregoCadastrarView(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFiltersAndList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                // Implemente o filtro por título aqui, se necessário
              });
            },
            decoration: InputDecoration(
              labelText: 'Pesquisar',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: [
            /* for (var benefit in _getAllBenefits()) ...[
              FilterChip(
                label: Text(benefit),
                selected: selectedBenefits.contains(benefit),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedBenefits.add(benefit);
                    } else {
                      selectedBenefits.remove(benefit);
                    }
                    _filterEmpregoList();
                  });
                },
              ),
            ], */
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: selectedCity,
            onChanged: (newValue) {
              setState(() {
                selectedCity = newValue!;
                _filterEmpregoList();
              });
            },
            items: _getCitiesList().map<DropdownMenuItem<String>>((city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Localização',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: filteredEmpregoList.length,
            itemBuilder: (BuildContext ctx, index) {
              return GridTile(
                key: ValueKey(filteredEmpregoList[index].idArtefato),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    filteredEmpregoList[index].tituloArtefato,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(filteredEmpregoList[index].localizacaoEmprego),
                ),
                child: Image.asset(
                  'assets/images/jobs.jpg',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
