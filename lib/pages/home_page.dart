import 'package:ceplookup/model/via_cep_model.dart';
import 'package:ceplookup/pages/consulta_cep.dart';
import 'package:ceplookup/pages/detalhe_page.dart';
import 'package:ceplookup/repositories/viacep_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ViaCepRepository viaCepRepository = ViaCepRepository();
  List<ViaCepModel> _ceps = [];

  var cepContoller = TextEditingController();
  var apenasNaoConcluidos = false;
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      carregando = true;
    });
    _ceps = await viaCepRepository.obterceps();
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: const Center(child: Text("Lista de CEPs"))),
          floatingActionButton: FloatingActionButton.extended(
            label: const Row(
              children: [Text('Consultar '), Icon(Icons.search)],
            ),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConsultaCepPage(),
                  ));
              setState(() {
                carregando = true;
              });
              obterTarefas();
            },
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                carregando
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: Visibility(
                          visible: carregando,
                          replacement: ListView.builder(
                              itemCount: _ceps.length,
                              itemBuilder: (BuildContext bc, int index) {
                                var cep = _ceps[index];
                                return Dismissible(
                                    onDismissed: (DismissDirection
                                        dismissDirection) async {
                                      await viaCepRepository
                                          .remover(cep.objectId);
                                      obterTarefas();
                                    },
                                    key: Key(cep.cep),
                                    child: InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AdressDetailPage(
                                                        endereco: cep),
                                              ));
                                          setState(() {
                                            carregando = true;
                                          });
                                          obterTarefas();
                                        },
                                        child: Card(
                                          elevation: 4.0,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8.0),
                                          // Cor de fundo do Card no tema escuro
                                          child: ListTile(
                                            title: Text(
                                              "${cep.localidade} - ${cep.uf}",
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .white, // Cor do título no tema escuro
                                              ),
                                            ),
                                            subtitle: Text(
                                              cep.cep,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[
                                                    400], // Cor da descrição no tema escuro
                                              ),
                                            ),
                                          ),
                                        )));
                              }),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}
