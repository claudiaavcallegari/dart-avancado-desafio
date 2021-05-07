import 'package:desafio_dart_avancado/desafio_dart_avancado.dart';
import 'package:desafio_dart_avancado/models/cidade_model.dart';
import 'package:dio/dio.dart';

class CidadeRepository {
  Future<void> buscarCidades(int estado) async {
   // var url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$estado/distritos';
   var url= 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$estado/municipios';

    var dio = Dio();
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      List<dynamic> respData = response.data;
      print('Salvar cidades do estado: $estado ');

      await salvarCidades(respData, estado);
    } else {
      throw Exception('Erro ao buscar cidades. Retorno ${response.statusCode} ${response.statusMessage}');

    }
  }

  Future<void> salvarCidades(List cidades, int estado) async {
    var sql = '''INSERT INTO `cidade` 
    (`id`,  `nome`,`estado_id`)  VALUES (? ,? ,?);
        ''';

    var conn = await getConnection(true);

    for(var cidade in cidades){
      var cidadeModel = CidadeModel.fromMap(cidade);
      await conn.query(sql, [cidadeModel.id, cidadeModel.nome, estado]);

    }
    
    await conn.close();
  }
}
