import 'package:dtplan_app/services/api_service.dart';
import 'package:flutter/material.dart';
import '../../services/token_service.dart';
import '../../models/treino/exercicio/ExercicioMusculacao.dart';
import 'detalhar_treino_musculacao_screen.dart';
import '../../models/treino/treino.dart';
import 'dart:convert';


class TreinoScreen extends StatefulWidget {
  @override
  _TreinoScreenState createState() => _TreinoScreenState();
}

class _TreinoScreenState extends State<TreinoScreen> {
  final TokenService _tokenService = TokenService();
  late Future<List<Treino>> _listaDeTreinos;

  @override
  void initState() {
    super.initState();
    _listaDeTreinos = _carregarTreinosData();
  }

  Future<List<Treino>> _carregarTreinosData() async {
  final token = await _tokenService.getToken();
  final apiService = ApiService();
  final response = await apiService.getTreinos(token!);

  print(json.decode(utf8.decode(response.bodyBytes))); // Debug

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
    List<dynamic> data = responseData['content'];
    List<Treino> treinos = data.map<Treino>((item) {
      return Treino(
        id: item['id'],
        descricao: item['descricao'],
        autor: item['autor'],
        tipo: item['tipo'],
      );
    }).toList();
    return treinos;
  } else {
    throw Exception('Erro ao buscar treinos do usuário: ${response.statusCode}');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treinos'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Treino>>(
        future: _listaDeTreinos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar treinos: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final treino = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(treino.descricao),
                    subtitle: Text('Autor: ${treino.autor} - Tipo: ${treino.tipo}'),
                    onTap: () {
                      if (treino.tipo == 'MUSCULACAO') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalharTreinoMusculacaoScreen(treinoId: treino.id!),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ao pressionar o botão de adição (+), exibe um menu de escolha
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //title: Text("Escolha o que criar"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text("Criar Exercício"),
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/exercicio/cadastrar');
                      },
                    ),
                    ListTile(
                      title: Text("Criar Treino"),
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/treino/cadastrar');
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

void main() {
  runApp(MaterialApp(
    home: TreinoScreen(),
  ));
}
