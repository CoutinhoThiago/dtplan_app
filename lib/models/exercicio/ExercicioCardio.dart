import 'exercicio.dart';

class ExercicioCardio extends Exercicio {
  final double duracaoMinutos;
  final double intensidade;

  ExercicioCardio({
    required String descricao,
    required this.duracaoMinutos,
    required this.intensidade,
  }) : super(descricao: descricao);
}
