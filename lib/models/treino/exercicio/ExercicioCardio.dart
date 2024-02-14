import 'exercicio.dart';

class ExercicioCardio extends Exercicio {
  final int? fichaId; // Adicionado o campo 'fichaId'
  final double duracaoMinutos;
  final double intensidade;

  ExercicioCardio({
    required this.fichaId,
    required String descricao,
    required this.duracaoMinutos,
    required this.intensidade,
  }) : super(
          fichaId: fichaId,
          descricao: descricao,
          series: 0, // Ajuste para cardio
          repeticoesMin: 0, // Ajuste para cardio
          repeticoesMax: 0, // Ajuste para cardio
          carga: 0, // Ajuste para cardio
        );

  factory ExercicioCardio.fromJson(Map<String, dynamic> json) {
    return ExercicioCardio(
      fichaId: json['id'],
      descricao: json['descricao'],
      duracaoMinutos: json['duracao_minutos'].toDouble(), // Converter para double
      intensidade: json['intensidade'].toDouble(), // Converter para double
    );
  }
}