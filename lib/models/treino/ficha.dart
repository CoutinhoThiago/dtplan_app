import 'exercicio/exercicio.dart';
import './treino.dart';


class Ficha {
  final int? id; // Adicione o campo 'id'
  final String nome; // Adicione o campo 'nome'
  final Treino treino; // Adicione o campo 'treino'
  List<Exercicio> exercicios; // Remova o modificador 'final'

  Ficha({
    required this.id, // Adicione o parâmetro 'id'
    required this.nome, // Adicione o parâmetro 'nome'
    required this.treino, // Adicione o parâmetro 'treino'
    required this.exercicios,
  });

  factory Ficha.fromJson(Map<String, dynamic> json) {
    List<Exercicio> exercicios = List<Exercicio>.from(json['exercicios'].map((x) => Exercicio.fromJson(x)));

    return Ficha(
      id: json['id'], // Preencha o campo 'id' com o valor do JSON
      nome: json['nome'], // Preencha o campo 'nome' com o valor do JSON
      treino: Treino(
        id: json['treino']['id'], // Preencha o campo 'id' do treino com o valor do JSON
        descricao: json['treino']['descricao'], // Preencha o campo 'descricao' do treino com o valor do JSON
        autor: json['treino']['autor'], // Preencha o campo 'autor' do treino com o valor do JSON
        tipo: json['treino']['tipo'], // Preencha o campo 'tipo' do treino com o valor do JSON
      ),
      exercicios: exercicios,
    );
  }
}
