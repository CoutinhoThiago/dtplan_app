import 'exercicio.dart';

class ExercicioMusculacao extends Exercicio {
  final int? id; // Adicionado o campo 'fichaId'
  final String? musculoAlvo;
  final int? series;
  final int? repeticoesMin;
  final int? repeticoesMax;
  final int? carga;

  ExercicioMusculacao({
    required this.id,
    required String? nome,
    required this.series,
    required this.musculoAlvo,
    required this.repeticoesMin,
    required this.repeticoesMax,
    required this.carga,
  }) : super(
    id: id,
    nome: nome,
    series: series, // Ajuste para cardio
    repeticoesMin: repeticoesMin, // Ajuste para cardio
    repeticoesMax: repeticoesMax, // Ajuste para cardio
    carga: carga, // Ajuste para cardio
  );

  factory ExercicioMusculacao.fromJson(Map<String, dynamic> json) {
    return ExercicioMusculacao(
      id: json['id'],
      nome: json['nome'],
      series: json['series'],
      musculoAlvo: json['musculo_alvo'],
      repeticoesMin: json['repeticoes_min'],
      repeticoesMax: json['repeticoes_max'],
      carga: json['carga'] ?? 0,
    );
  }
}
