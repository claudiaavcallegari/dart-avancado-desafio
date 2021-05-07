import 'package:desafio_dart_avancado/models/estado_model.dart';
import 'package:dio/dio.dart';
import 'package:desafio_dart_avancado/desafio_dart_avancado.dart';

class EstadoRepository {
  Future<List> buscarEstados() async {
    print('Buscar lista de estados');

    var url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    var dio = Dio();
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      List<dynamic> respData = response.data;
      await salvarEstados(respData, 1);

      return respData;
    } else {
        throw Exception('Erro ao buscar estados. Retorno ${response.statusCode} ${response.statusMessage}');

    }
  }

  Future<void> salvarEstados(List estados, int pais) async {
    print('Salvar Estados');
    var conn = await getConnection(true);

    var sql = '''INSERT INTO `estado` 
    (`id`, `sigla`, `nome`,`pais_id`)  VALUES (? ,?,? ,?);
        ''';


    for (var estado in estados) {
      var estadoModel = EstadoModel.fromMap(estado);
      await conn.query(
          sql, [estadoModel.id, estadoModel.sigla, estadoModel.nome, pais]);

    }

    await conn.close();
  }
}
