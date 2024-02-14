import 'package:flutter/material.dart';
import '../../models/treino/exercicio/ExercicioMusculacao.dart'; // Ajuste o caminho conforme necessário

class DetalharExercicioScreen extends StatelessWidget {
  final ExercicioMusculacao exercicio;

  DetalharExercicioScreen({required this.exercicio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Exercício'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercicio.descricao,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Músculo Alvo: ${exercicio.musculoAlvo}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Séries: ${exercicio.series}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Repetições: ${exercicio.repeticoesMin} - ${exercicio.repeticoesMax}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Carga: ${exercicio.carga}kg',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
