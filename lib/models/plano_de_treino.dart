import 'treino.dart';

class PlanoTreino {
  final String nome;
  final String autor;
  final String tipo;
  final List<Treino> treinos;

  PlanoTreino({
    required this.nome,
    required this.autor,
    required this.tipo,
    required this.treinos,
  });
}
