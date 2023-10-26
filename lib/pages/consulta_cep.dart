import 'package:ceplookup/repositories/viacep_repository.dart';
import 'package:flutter/material.dart';

class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  TextEditingController cepController = TextEditingController();
  bool isEdit = false;
  final ViaCepRepository _cepRepository = ViaCepRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Consulta Cep')),
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        TextField(
          controller: cepController,
          decoration: const InputDecoration(hintText: 'CEP'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.green.shade400)),
            onPressed: () async {
              var cep = await _cepRepository.consultarCEP(cepController.text);
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Consulta'),
            ))
      ]),
    ));
  }
}
