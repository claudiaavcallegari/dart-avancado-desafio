import 'package:desafio_dart_avancado/repository/cidade_repository.dart';
import 'package:mysql1/mysql1.dart';
import 'package:desafio_dart_avancado/repository/estado_repository.dart';

Future<void> run() async {
  try {
    await criarBanco();
    await criarTabelas();

    var estadoRepository = EstadoRepository();
    var cidadeRepository = CidadeRepository();

    var estados =
        await estadoRepository.buscarEstados(); // busca e ja salva os estados


    for(var estado in estados ){
      var estadoId = estado['id'];
      await cidadeRepository
          .buscarCidades(estadoId); // busca e ja salva as cidades

    }


  } catch (e) {
    print('Erro: $e');
  }
}

Future<MySqlConnection> getConnection(bool banco) async {
  var database;

  if (banco) {
    database = 'desafio_dart_avancado';
  } else {
    database = '';
  }

  var settings = ConnectionSettings(
      host: 'localhost',
      port: 3310,
      user: 'root',
      password: 'root',
      db: database);

  var conn = await MySqlConnection.connect(settings);

  return conn;
}

Future<void> dropBanco() async {
  var conn = await getConnection(false);
  var sql1 = ''' DROP SCHEMA IF EXISTS `desafio_dart_avancado`   
    ''';

  await conn.query(sql1);

  await conn.close();
}

Future<void> criarBanco() async {
  print('Criar banco de dados');
  await dropBanco();

  var conn = await getConnection(false);
  var sql1 = ''' CREATE SCHEMA IF NOT EXISTS `desafio_dart_avancado` 
  DEFAULT CHARACTER SET utf8 ; 
    ''';

  await conn.query(sql1);

  await conn.close();
}

Future<void> criarTabelas() async {
  print('Criar tabelas');

  var conn = await getConnection(true);
  var sql1 = '''CREATE TABLE IF NOT EXISTS `pais` (
  `id` INT NOT NULL   PRIMARY KEY  AUTO_INCREMENT,
  `pais` VARCHAR(200) NOT NULL   )
ENGINE = InnoDB; ''';
  var sql2 = 'insert into pais (id, pais) values( null,"Brasil")';

  var sql3 = ''' CREATE TABLE IF NOT EXISTS `estado` (
  `id` INT NOT NULL   ,
  `sigla` VARCHAR(2) NOT NULL ,
  `nome` VARCHAR(255) NOT NULL ,
  `pais_id` INT NOT NULL  

  )
ENGINE = InnoDB;	''';

  var sql4 = '''CREATE TABLE IF NOT EXISTS `cidade` (
  `id` INT NOT NULL   ,
  `nome` VARCHAR(255) NOT NULL ,
  `estado_id` INT NOT NULL  
  )
ENGINE = InnoDB;	''';

  await conn.query(sql1);
  await conn.query(sql2);
  await conn.query(sql3);
  await conn.query(sql4);

  await conn.close();
}
