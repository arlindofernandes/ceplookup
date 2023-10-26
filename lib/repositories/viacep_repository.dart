import 'package:ceplookup/model/via_cep_model.dart';
import 'package:ceplookup/repositories/custon_dio.dart';

class ViaCepRepository {
  final _diob4 = CustonDio();

  ViaCepRepository();

  Future<ViaCepModel> consultarCEP(String Cep) async {
    List<ViaCepModel> Ceps;
    final dio = CustonDio();
    Ceps = await obterceps();
    var response = await dio.dio.get("https://viacep.com.br/ws/$Cep/json/");
    if (response.statusCode == 200) {
      ViaCepModel cep = ViaCepModel.fromJson(response.data);
      if (Ceps.any((element) => element.cep != cep.cep) == true) {
        await criar(cep);
      }
      return cep;
    }
    return ViaCepModel.vazio();
  }

  Future<List<ViaCepModel>> obterceps() async {
    var ceps = <ViaCepModel>[];
    var result = await _diob4.dio.get("/viacep");
    print(result);
    Map<String, dynamic> json = result.data;
    if (json['results'] != null) {
      json['results'].forEach((v) {
        ceps.add(ViaCepModel.fromJson(v));
      });
    }
    return ceps;
  }

  Future criar(ViaCepModel viaCepModel) async {
    try {
      await _diob4.dio.post("/viacep", data: viaCepModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future atualizar(ViaCepModel viaCepModel) async {
    try {
      await _diob4.dio
          .put("/viacep/${viaCepModel.objectId}", data: viaCepModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future remover(String id) async {
    try {
      await _diob4.dio.delete("/viacep/$id");
    } catch (e) {
      throw e;
    }
  }
}
