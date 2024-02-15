class Exercicio {
  final int? id; // Adicionado o campo 'fichaId'
  final String? nome;
  final int? series;
  final int? repeticoesMin;
  final int? repeticoesMax;
  final int? carga;

  Exercicio({
    required this.id,
    required this.nome,
    required this.series,
    required this.repeticoesMin,
    required this.repeticoesMax,
    required this.carga,
  });

  factory Exercicio.fromJson(Map<String, dynamic> json) {
    return Exercicio(
      id: json['id'],
      nome: json['nome'],
      series: json['series'],
      repeticoesMin: json['repeticoes_min'],
      repeticoesMax: json['repeticoes_max'],
      carga: json['carga'],
    );
  }
}