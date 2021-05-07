import 'dart:convert';

class EstadoModel {
  final int id;
  final String sigla;
  final String nome;
  final int pais_id;

  EstadoModel({
     this.id,
     this.sigla,
     this.nome,
     this.pais_id
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sigla': sigla,
      'nome': nome,

    };
  }

  factory EstadoModel.fromMap(Map<String, dynamic> map) {
    return EstadoModel(
      id: map['id']?.toInt(),
      sigla: map['sigla'],
      nome: map['nome'],

    );
  }

  String toJson() => json.encode(toMap());

  factory EstadoModel.fromJson(String source) => EstadoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EstadoModel(id: $id, sigla: $sigla, nome: $nome)';
  }

  

 
}

