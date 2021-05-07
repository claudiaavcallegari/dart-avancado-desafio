import 'dart:convert';

class CidadeModel {
  final int id;
  final String nome;
  final int estado_id;

  CidadeModel({
     this.id,
     this.nome,
     this.estado_id
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  factory CidadeModel.fromMap(Map<String, dynamic> map) {
    return CidadeModel(
      id: map['id']?.toInt(),
      nome: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CidadeModel.fromJson(String source) => CidadeModel.fromMap(json.decode(source));

  @override
  String toString() => 'CidadeModel(id: $id, nome: $nome)';

  

  
}