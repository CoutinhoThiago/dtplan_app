import 'package:intl/intl.dart';

class Usuario {
  final String nome;
  final String cpf;
  final DateTime dataNascimento;
  final double? altura;
  final double? pesoAtual;
  final String nivelAtividade;
  final String objetivo;

  Usuario({
    required this.nome,
    required this.cpf, // Adicionando o campo CPF
    required this.dataNascimento,
    required this.altura,
    required this.pesoAtual,
    required this.nivelAtividade,
    required this.objetivo,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    try {
      return Usuario(
        nome: json['nome'],
        cpf: json['cpf'], // Mapeando o campo CPF
        dataNascimento: DateTime.parse(json['dataNascimento']),
        altura: json['altura']?.toDouble(),
        pesoAtual: json['pesoAtual']?.toDouble(),
        nivelAtividade: json['nivelAtividade'],
        objetivo: json['objetivo'],
      );
    } catch (e) {
      throw FormatException('Erro ao converter JSON para Usuario: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cpf': cpf, // Incluindo o campo CPF na serialização
      'dataNascimento': DateFormat('yyyy-MM-dd').format(dataNascimento),
      'altura': altura,
      'pesoAtual': pesoAtual,
      'nivelAtividade': nivelAtividade,
      'objetivo': objetivo,
    };
  }

  int calcularIdade() {
    final now = DateTime.now();
    int age = now.year - dataNascimento.year;
    if (now.month < dataNascimento.month ||
        (now.month == dataNascimento.month && now.day < dataNascimento.day)) {
      age--;
    }
    return age;
  }
}
