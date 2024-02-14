class Exercicio {
  final int? fichaId; // Adicionado o campo 'fichaId'
  final String descricao;
  final int? series;
  final int? repeticoesMin;
  final int? repeticoesMax;
  final int? carga;

  Exercicio({
    required this.fichaId,
    required this.descricao,
    required this.series,
    required this.repeticoesMin,
    required this.repeticoesMax,
    required this.carga,
  });

  factory Exercicio.fromJson(Map<String, dynamic> json) {
    return Exercicio(
      fichaId: json['id'],
      descricao: json['descricao'],
      series: json['series'],
      repeticoesMin: json['repeticoes_min'],
      repeticoesMax: json['repeticoes_max'],
      carga: json['carga'],
    );
  }
}