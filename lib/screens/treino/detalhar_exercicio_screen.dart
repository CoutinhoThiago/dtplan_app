import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data'; // Adicionando a importação para o dart:typed_data
import '../../models/treino/exercicio/exercicioMusculacao.dart';
import '../../services/api_service.dart';
import '../../services/token_service.dart';

class DetalharExercicioScreen extends StatefulWidget {
  final int exercicioId;

  DetalharExercicioScreen({required this.exercicioId});

  @override
  _DetalharExercicioScreenState createState() =>
      _DetalharExercicioScreenState();
}

class _DetalharExercicioScreenState extends State<DetalharExercicioScreen> {
  late Future<ExercicioMusculacao?> _futureExercicio;
  final ApiService _apiService = ApiService();
  final TokenService _tokenService = TokenService();

  @override
  void initState() {
    super.initState();
    _futureExercicio = _carregarExercicio(widget.exercicioId);
  }

  Future<ExercicioMusculacao?> _carregarExercicio(int exercicioId) async {
    try {
      final token = await _tokenService.getToken();
      final response = await _apiService.getExercicio(token!, exercicioId.toString());
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
        return ExercicioMusculacao.fromJson(responseData);
      } else {
        throw Exception('Erro ao carregar detalhes do exercício: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao carregar detalhes do exercício: $error');
    }
  }

  Future<Widget> _carregarGif(int exercicioId) async {
    try {
      if (exercicioId == 1) { // Se o ID do exercício for 2 (Supino reto com barra)
        final data = await rootBundle.load('../../../assets/gifs/supinoInclinadoHalter.webp');
        final image = Image.memory(Uint8List.view(data.buffer)); // Retorna a imagem carregada como um Widget de imagem
        return _roundedImage(image);
      }
      else if (exercicioId == 2) { // Se o ID do exercício for 2 (Supino reto com barra)
        final data = await rootBundle.load('../../../assets/gifs/supinoRetoBarra.webp');
        final image = Image.memory(Uint8List.view(data.buffer)); // Retorna a imagem carregada como um Widget de imagem
        return _roundedImage(image);
      }
      else {
        return SizedBox(); // Se o ID do exercício não corresponder, retorna um widget vazio
      }
    } catch (error) {
      throw Exception('Erro ao carregar o GIF: $error');
    }
  }
  Widget _roundedImage(Widget image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0), // Define o raio do arredondamento
      child: image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do Exercício',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blueGrey[900], // Cor de fundo do app bar
        centerTitle: true, // Centralizando o título
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              FutureBuilder<Widget>(
                future: _carregarGif(widget.exercicioId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar o GIF: ${snapshot.error}');
                  } else {
                    return snapshot.data!;
                  }
                },
              ),
              SizedBox(height: 20),
              FutureBuilder<ExercicioMusculacao?>(
                future: _futureExercicio,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return _buildExercicioDetails(snapshot.data!);
                  } else {
                    return Text('Nenhum dado encontrado.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200], // Cor de fundo do corpo da tela
    );
  }

  Widget _buildExercicioDetails(ExercicioMusculacao exercicio) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            exercicio.nome ?? 'Nome não disponível',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Músculo Alvo: ${exercicio.musculoAlvo ?? 'Não especificado'}',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Séries: ${exercicio.series ?? 'Não especificado'}',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Repetições: ${exercicio.repeticoesMin ?? 'Não especificado'} - ${exercicio.repeticoesMax ?? 'Não especificado'}',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Carga: ${exercicio.carga ?? 'Não especificado'}kg',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
