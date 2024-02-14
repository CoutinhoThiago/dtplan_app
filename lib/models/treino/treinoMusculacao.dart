import 'treino.dart';
import './ficha.dart';

class TreinoMusculacao extends Treino {
  List<Ficha> fichas;

  TreinoMusculacao({
    required int? id,
    required String descricao,
    required String autor,
    required String tipo,
    required this.fichas,
  }) : super(id: id, descricao: descricao, autor: autor, tipo: tipo);

  factory TreinoMusculacao.fromJson(Map<String, dynamic> json) {
    // Parse dos dados do JSON
    List<Ficha> fichas = (json['fichas'] as List)
        .map((fichaJson) => Ficha.fromJson(fichaJson))
        .toList();

    // Retorna uma nova instância de TreinoMusculacao com os dados parseados
    return TreinoMusculacao(
      id: json['id'],
      descricao: json['descricao'],
      autor: json['autor'],
      tipo: json['tipo'],
      fichas: fichas,
    );
  }
}
