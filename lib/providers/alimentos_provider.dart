import 'package:flutter/material.dart';
import '../models/dieta/alimento.dart';

class AlimentosProvider with ChangeNotifier {
  final List<Alimento> _alimentos = [
    Alimento(
      nome: "Maçã",
      quantidade: 100, // Quantidade em gramas
      porcao: "1 média (aprox. 100g)",
      proteina: 0.3,
      carboidrato: 13.8,
      gordura: 0.2,
      calorias: 52,
    ),
    Alimento(
      nome: "Peito de Frango Grelhado",
      quantidade: 100, // Quantidade em gramas
      porcao: "100g",
      proteina: 31,
      carboidrato: 0,
      gordura: 3.6,
      calorias: 165,
    ),
    Alimento(
      nome: "Arroz Branco Cozido",
      quantidade: 100, // Quantidade em gramas
      porcao: "1/2 xícara",
      proteina: 2.7,
      carboidrato: 28,
      gordura: 0.3,
      calorias: 130,
    ),
    Alimento(
      nome: "Banana",
      quantidade: 100, // Quantidade em gramas
      porcao: "1 média (aprox. 100g)",
      proteina: 1.1,
      carboidrato: 22.8,
      gordura: 0.3,
      calorias: 89,
    ),
    Alimento(
      nome: "Aveia",
      quantidade: 100, // Quantidade em gramas
      porcao: "1 xícara",
      proteina: 16.9,
      carboidrato: 66.3,
      gordura: 6.9,
      calorias: 389,
    ),
    Alimento(
      nome: "Amêndoas",
      quantidade: 100, // Quantidade em gramas
      porcao: "1 xícara",
      proteina: 21.1,
      carboidrato: 21.6,
      gordura: 49.9,
      calorias: 579,
    ),
    Alimento(
      nome: "Salmão Grelhado",
      quantidade: 100, // Quantidade em gramas
      porcao: "1 filé (aprox. 200g)",
      proteina: 25.4,
      carboidrato: 0,
      gordura: 13.4,
      calorias: 208,
    ),
    Alimento(
      nome: "Brócolis Cozido",
      quantidade: 100, // Quantidade em gramas
      porcao: "1 xícara",
      proteina: 2.5,
      carboidrato: 5.1,
      gordura: 0.4,
      calorias: 35,
    ),
  ];

  List<Alimento> get alimentos {
    return [..._alimentos];
  }

  void adicionarAlimento(Alimento alimento) {
    _alimentos.add(alimento);
    notifyListeners();
  }
}
