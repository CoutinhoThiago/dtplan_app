import 'package:flutter/material.dart';
import '../models/alimento.dart';

class AlimentosProvider with ChangeNotifier {
  List<Alimento> _alimentos = [
    Alimento(nome: 'Ovos', porcao: '100g', proteina: 13, carboidrato: 1.1, gordura: 11, calorias: 155),
    Alimento(nome: 'Frango', porcao: '100g', proteina: 27, carboidrato: 0, gordura: 14, calorias: 239),
    Alimento(nome: 'Salmão', porcao: '100g', proteina: 20, carboidrato: 0, gordura: 13, calorias: 208),
    Alimento(nome: 'Abacate', porcao: '100g', proteina: 2, carboidrato: 8.5, gordura: 14.7, calorias: 160),
    Alimento(nome: 'Quinoa', porcao: '100g', proteina: 4.1, carboidrato: 21.3, gordura: 1.9, calorias: 120),
    Alimento(nome: 'Aveia', porcao: '100g', proteina: 16.9, carboidrato: 66.3, gordura: 6.9, calorias: 389),
    Alimento(nome: 'Frango Grelhado', porcao: '100g', proteina: 31, carboidrato: 0, gordura: 3.6, calorias: 165),
    Alimento(nome: 'Batata Doce', porcao: '100g', proteina: 1.6, carboidrato: 20.1, gordura: 0.1, calorias: 86),
    Alimento(nome: 'Brócolis', porcao: '100g', proteina: 3.7, carboidrato: 11.2, gordura: 0.6, calorias: 55),
    Alimento(nome: 'Quinoa', porcao: '100g', proteina: 4.1, carboidrato: 21.3, gordura: 1.9, calorias: 120),
  ];

  List<Alimento> get alimentos {
    return [..._alimentos];
  }

  void adicionarAlimento(Alimento alimento) {
    _alimentos.add(alimento);
    notifyListeners();
  }
}
