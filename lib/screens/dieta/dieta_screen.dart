import 'package:flutter/material.dart';
import '../../models/dieta/dieta.dart';
import '../../models/dieta/refeicao.dart';
import '../../models/dieta/alimento.dart'; // Importe a classe Alimento se necessário
import './detalhar_refeicao_screen.dart';

class DietaScreen extends StatelessWidget {
  // Exemplo de Dieta para demonstração
  final Dieta dieta = Dieta(
    descricao: "Dieta de Exemplo",
    refeicoes: [
      Refeicao(
        nome: "Café da Manhã",
        alimentos: [
          Alimento(nome: "Aveia", quantidade: 50, calorias: 190, porcao: "50g", proteina: 5, carboidrato: 32, gordura: 3.5),
          Alimento(nome: "Banana", quantidade: 1, calorias: 89, porcao: "1 unidade média", proteina: 1.1, carboidrato: 22.8, gordura: 0.3),
        ],
      ),
      Refeicao(
        nome: "Almoço",
        alimentos: [
          Alimento(nome: "Peito de frango", quantidade: 100, calorias: 165, porcao: "100g", proteina: 31, carboidrato: 0, gordura: 3.6),
          Alimento(nome: "Arroz branco", quantidade: 100, calorias: 130, porcao: "100g", proteina: 2.7, carboidrato: 28, gordura: 0.3),
        ],
      ),
      // Adicione mais refeições conforme necessário
    ],
  );

  DietaScreen({Key? key}) : super(key: key); // Adicione um construtor se necessário

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dieta'),
        centerTitle: true,
        
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: 'Menu',
        ),
      ),
      body: ListView.builder(
        itemCount: dieta.refeicoes.length,
        itemBuilder: (context, index) {
          final refeicao = dieta.refeicoes[index];
          return ListTile(
            title: Text(refeicao.nome),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalharRefeicaoScreen(refeicao: refeicao),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ao pressionar o botão de adição (+), exibe um menu de escolha
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text("Cadastrar alimento"),
                      onTap: () {
                        //Navigator.popAndPushNamed(context, '/exercicio/cadastrar');
                      },
                    ),
                    ListTile(
                      title: Text("Cadastrar Refeição"),
                      onTap: () {
                        //Navigator.popAndPushNamed(context, '/treino/cadastrar');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        tooltip: 'Adicionar Treino ou Exercício',
        child: Icon(Icons.add),
      ),
    );
  }
}
