import 'exercicio.dart';

class ExercicioMusculacao extends Exercicio {
  final String musculoAlvo;
  final int series;
  final int repeticoesMin;
  final int repeticoesMax;
  final double carga;

  ExercicioMusculacao( {
    required String descricao,
    required this.musculoAlvo,
    required this.series,
    required this.repeticoesMin,
    required this.repeticoesMax,
    required this.carga,
  }) : super(descricao: descricao);
}
