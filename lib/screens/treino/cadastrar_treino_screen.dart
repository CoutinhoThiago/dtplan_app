import 'package:flutter/material.dart';
import '../../models/treino/exercicio/exercicio.dart'; 
import '../../models/treino/treino.dart'; 
import 'cadastrar_exercicio_screen.dart';

class CadastrarTreinoScreen extends StatefulWidget {
  @override
  _CadastrarTreinoScreenState createState() => _CadastrarTreinoScreenState();
}

class _CadastrarTreinoScreenState extends State<CadastrarTreinoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _descricao;
  late String _dia;
  late String _autor;
  late String _tipo;
  List<Exercicio> _exercicios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Treino'),
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
                    return 'Por favor, insira a descrição do treino';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descricao = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dia'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o dia do treino';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dia = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o autor do treino';
                  }
                  return null;
                },
                onSaved: (value) {
                  _autor = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o tipo do treino';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tipo = value!;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastrarExercicioScreen(),
                    ),
                  );
                  if (result != null && result is Exercicio) {
                    setState(() {
                      _exercicios.add(result);
                    });
                  }
                },
                child: Text('Adicionar Exercício'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _exercicios.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_exercicios[index].descricao),
                      // Exemplo: Substitua "descricao" pelo campo adequado do seu Exercicio
                      onTap: () {
                        // Adicione ação de detalhes se necessário
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Treino novoTreino = Treino(
                        descricao: _descricao,
                        autor: _autor,
                        tipo: _tipo,
                      );
                      // Aqui você pode salvar ou enviar o novoTreino
                      // Exemplo: _seuServico.salvarTreino(novoTreino);
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
