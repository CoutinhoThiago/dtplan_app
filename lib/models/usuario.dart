class Usuario {
  String nome;
  int idade;
  double altura;
  double peso;
  String nivelAtividade;
  String objetivo;
  String? imagePath; // Declarar imagePath como uma String opcional

  Usuario({
    required this.nome,
    required this.idade,
    required this.altura,
    required this.peso,
    required this.nivelAtividade,
    required this.objetivo,
    this.imagePath, // Adicionar imagePath ao construtor com valor padrão nulo
  });
}
