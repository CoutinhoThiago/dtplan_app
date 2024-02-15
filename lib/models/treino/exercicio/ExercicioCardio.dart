import 'exercicio.dart';

class ExercicioCardio extends Exercicio {
  final int? id; // Adicionado o campo 'fichaId'
  final double duracaoMinutos;
  final double intensidade;

  ExercicioCardio({
    required this.id,
    required String? nome,
    required this.duracaoMinutos,
    required this.intensidade,
  }) : super(
          id: id,
          nome: nome,
          series: 0, // Ajuste para cardio
          repeticoesMin: 0, // Ajuste para cardio
          repeticoesMax: 0, // Ajuste para cardio
          carga: 0, // Ajuste para cardio
        );

  factory ExercicioCardio.fromJson(Map<String, dynamic> json) {
    return ExercicioCardio(
      id: json['id'],
      nome: json['nome'],
      duracaoMinutos: json['duracao_minutos'].toDouble(), // Converter para double
      intensidade: json['intensidade'].toDouble(), // Converter para double
    );
  }
}