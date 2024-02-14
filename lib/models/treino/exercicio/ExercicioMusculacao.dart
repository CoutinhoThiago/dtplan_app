import 'exercicio.dart';

class ExercicioMusculacao extends Exercicio {
  final int? fichaId; // Adicionado o campo 'fichaId'
  final String musculoAlvo;
  final int? repeticoesMin;
  final int? repeticoesMax;
  final int? carga;

  ExercicioMusculacao({
    required this.fichaId,
    required String descricao,
    required this.musculoAlvo,
    required this.repeticoesMin,
    required this.repeticoesMax,
    required this.carga,
  }) : super(
    fichaId: fichaId,
    descricao: descricao,
    series: 0, // Ajuste para cardio
    repeticoesMin: 0, // Ajuste para cardio
    repeticoesMax: 0, // Ajuste para cardio
    carga: 0, // Ajuste para cardio
  );

  factory ExercicioMusculacao.fromJson(Map<String, dynamic> json) {
    return ExercicioMusculacao(
      fichaId: json['id'],
      descricao: json['descricao'],
      musculoAlvo: json['musculo_alvo'],
      repeticoesMin: json['repeticoes_min'],
      repeticoesMax: json['repeticoes_max'],
      carga: json['carga'] ?? 0,
    );
  }
}
