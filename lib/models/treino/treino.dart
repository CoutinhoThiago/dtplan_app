class Treino {
  final int? id; // Tornando o id opcional
  final String descricao;
  final String autor;
  final String tipo;
  final int? usuarioId;

  Treino({
    this.id, // Deixando o id opcional
    required this.descricao,
    required this.autor,
    required this.tipo,
    required this.usuarioId,
  });
}