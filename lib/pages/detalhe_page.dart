import 'package:ceplookup/model/via_cep_model.dart';
import 'package:flutter/material.dart';

class AdressDetailPage extends StatelessWidget {
  final ViaCepModel endereco;
  const AdressDetailPage({super.key, required this.endereco});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: endereco.objectId,
      child: SafeArea(
        child: Scaffold(
          //appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on, // Ícone de localização
                      size: 48,
                      color: Colors.blue, // Cor do ícone
                    ),
                    Text(
                      endereco.cep,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  'Cidade : ${endereco.localidade.isNotEmpty ? endereco.localidade : '---'} ',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Rua : ${endereco.logradouro.isNotEmpty ? endereco.logradouro : '---'} ',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Bairro : ${endereco.bairro.isNotEmpty ? endereco.bairro : '---'} ',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Complemento : ${endereco.complemento.isNotEmpty ? endereco.complemento : '---'} ',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'UF : ${endereco.uf.isNotEmpty ? endereco.uf : '---'} ',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
