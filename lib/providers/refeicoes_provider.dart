import '../models/dieta/alimento.dart';

class Refeicao {
  final String nome;
  final List<Alimento> alimentos;

  Refeicao({
    required this.nome,
    required this.alimentos,
  });

  double get totalCalorias {
    double calorias = 0.0;
    for (var alimento in alimentos) {
      calorias += alimento.calorias;
    }
    return calorias;
  }

  double get totalProteinas {
    double proteinas = 0.0;
    for (var alimento in alimentos) {
      proteinas += alimento.proteina;
    }
    return proteinas;
  }

  double get totalCarboidratos {
    double carboidratos = 0.0;
    for (var alimento in alimentos) {
      carboidratos += alimento.carboidrato;
    }
    return carboidratos;
  }

  double get totalGorduras {
    double gorduras = 0.0;
    for (var alimento in alimentos) {
      gorduras += alimento.gordura;
    }
    return gorduras;
  }

  @override
  String toString() {
    return 'Refeição: $nome\n' +
        'Total de Calorias: ${totalCalorias} kcal\n' +
        'Proteínas: ${totalProteinas} g\n' +
        'Carboidratos: ${totalCarboidratos} g\n' +
        'Gorduras: ${totalGorduras} g';
  }
}
