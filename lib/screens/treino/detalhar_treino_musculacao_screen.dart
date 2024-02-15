import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dtplan_app/services/api_service.dart';
import '../../services/token_service.dart';
import '../../models/treino/ficha.dart';
import '../../models/treino/treinoMusculacao.dart';
import '../../models/treino/exercicio/exercicioMusculacao.dart';

class DetalharTreinoMusculacaoScreen extends StatefulWidget {
  final int treinoId;

  DetalharTreinoMusculacaoScreen({required this.treinoId});

  @override
  _DetalharTreinoMusculacaoScreenState createState() =>
      _DetalharTreinoMusculacaoScreenState();
}

class _DetalharTreinoMusculacaoScreenState
    extends State<DetalharTreinoMusculacaoScreen> {
  late Future<TreinoMusculacao> _futureTreinoMusculacao;
  final ApiService _apiService = ApiService();
  final TokenService _tokenService = TokenService();

  @override
  void initState() {
    super.initState();
    _futureTreinoMusculacao =
        _carregarTreinoMusculacao(widget.treinoId);
  }

  Future<TreinoMusculacao> _carregarTreinoMusculacao(
      int treinoId) async {
    try {
      final token = await _tokenService.getToken();
      final response =
          await _apiService.getTreino(token!, treinoId.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            json.decode(utf8.decode(response.bodyBytes));

        return TreinoMusculacao.fromJson(responseData);
      } else {
        throw Exception(
            'Erro ao buscar treino de musculação do usuário: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao carregar treino de musculação: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Treino'),
        centerTitle: true,
      ),
      body: FutureBuilder<TreinoMusculacao>(
        future: _futureTreinoMusculacao,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar treino: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return _buildTreinoMusculacaoScreen(snapshot.data!);
          } else {
            return Center(child: Text('Nenhum dado encontrado.'));
          }
        },
      ),
    );
  }

  Widget _buildTreinoMusculacaoScreen(TreinoMusculacao treinoMusculacao) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descrição do Treino:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(treinoMusculacao.descricao),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: treinoMusculacao.fichas.length,
              itemBuilder: (context, index) {
                final ficha = treinoMusculacao.fichas[index];
                return FichaItem(ficha: ficha);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FichaItem extends StatefulWidget {
  final Ficha ficha;

  const FichaItem({Key? key, required this.ficha}) : super(key: key);

  @override
  _FichaItemState createState() => _FichaItemState();
}

class _FichaItemState extends State<FichaItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            '${widget.ficha.nome}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        if (_isExpanded)
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.ficha.exercicios.length,
                itemBuilder: (context, index) {
                  final exercicio = widget.ficha.exercicios[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(exercicio.descricao),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Séries: ${exercicio.series}',
                          ),
                          Text(
                            'Repetições: ${exercicio.repeticoesMin}-${exercicio.repeticoesMax}',
                          ),
                          Text(
                            'Carga: ${exercicio.carga}',
                          ),
                          if (exercicio is ExercicioMusculacao)
                            Text(
                              'Músculo Alvo: ${exercicio.musculoAlvo}',
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Divider(),
            ],
          ),
      ],
    );
  }
}
