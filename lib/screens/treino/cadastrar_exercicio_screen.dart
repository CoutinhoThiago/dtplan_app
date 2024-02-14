import 'package:flutter/material.dart';
import '../../models/treino/exercicio/Exercicio.dart';
import '../../models/treino/exercicio/ExercicioMusculacao.dart';

class CadastrarExercicioScreen extends StatefulWidget {
  @override
  _CadastrarExercicioScreenState createState() =>
      _CadastrarExercicioScreenState();
}

class _CadastrarExercicioScreenState extends State<CadastrarExercicioScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _descricao;
  late String _musculoAlvo;
  late int _series;
  late int _repeticoesMin;
  late int _repeticoesMax;
  late double _carga;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Exercício'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do exercício';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descricao = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Músculo Alvo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o músculo alvo do exercício';
                  }
                  return null;
                },
                onSaved: (value) {
                  _musculoAlvo = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Séries'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de séries';
                  }
                  return null;
                },
                onSaved: (value) {
                  _series = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Repetições Mínimas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de repetições mínimas';
                  }
                  return null;
                },
                onSaved: (value) {
                  _repeticoesMin = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Repetições Máximas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de repetições máximas';
                  }
                  return null;
                },
                onSaved: (value) {
                  _repeticoesMax = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Carga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a carga do exercício';
                  }
                  return null;
                },
                onSaved: (value) {
                  _carga = double.parse(value!);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Criando uma instância de ExercicioMusculacao com os dados fornecidos
                      //ExercicioMusculacao novoExercicio = ExercicioMusculacao(
                      //  descricao: _descricao,
                      //  musculoAlvo: _musculoAlvo,
                      //  series: _series,
                      //  repeticoesMin: _repeticoesMin,
                      //  repeticoesMax: _repeticoesMax,
                      //  carga: _carga,
                      //);
                      // Aqui você pode salvar ou enviar o novoExercicio
                      // Exemplo: _seuServico.salvarExercicio(novoExercicio);
                      Navigator.pop(context); // Fecha a tela de cadastro após salvar
                    }
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
