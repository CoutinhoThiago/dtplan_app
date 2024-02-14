import 'package:flutter/material.dart';
import '../../models/dieta/alimento.dart'; // Ajuste o caminho conforme necessário

class DetalharAlimentoScreen extends StatelessWidget {
  final Alimento alimento;

  DetalharAlimentoScreen({required this.alimento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Alimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alimento.nome,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Quantidade: ${alimento.quantidade.toStringAsFixed(2)}g',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Calorias: ${alimento.calorias} kcal',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
