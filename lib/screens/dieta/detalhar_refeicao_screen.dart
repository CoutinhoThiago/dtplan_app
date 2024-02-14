import 'package:flutter/material.dart';
import '../../models/dieta/refeicao.dart'; // Ajuste o caminho conforme necessário
import './detalhar_alimento_screen.dart';


class DetalharRefeicaoScreen extends StatelessWidget {
  final Refeicao refeicao;

  DetalharRefeicaoScreen({required this.refeicao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Refeição - ${refeicao.nome}'),
      ),
      body: ListView.builder(
        itemCount: refeicao.alimentos.length,
        itemBuilder: (context, index) {
          final alimento = refeicao.alimentos[index];
          return ListTile(
            title: Text(alimento.nome),
            subtitle: Text('Quantidade: ${alimento.quantidade}g, Calorias: ${alimento.calorias} kcal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalharAlimentoScreen(alimento: alimento),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
