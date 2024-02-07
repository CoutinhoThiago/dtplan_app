import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  String _tipoContaSelecionada = 'Usuario'; // Valor padrão para o seletor de tipo de conta

  final List<String> _tiposConta = ['Professor', 'Usuario', 'Nutricionista']; // Opções para o seletor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Tipo de Conta',
                  border: OutlineInputBorder(),
                ),
                value: _tipoContaSelecionada,
                onChanged: (String? newValue) {
                  setState(() {
                    _tipoContaSelecionada = newValue!;
                  });
                },
                items: _tiposConta.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome Completo'),
                validator: (value) => value!.isEmpty ? 'Por favor, insira seu nome completo' : null,
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) => value!.isEmpty ? 'Por favor, insira seu CPF' : null,
              ),
              TextFormField(
                controller: _loginController,
                decoration: InputDecoration(labelText: 'Login'),
                validator: (value) => value!.isEmpty ? 'Por favor, insira um login' : null,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Por favor, insira uma senha' : null,
              ),
              TextFormField(
                controller: _confirmarSenhaController,
                decoration: InputDecoration(labelText: 'Confirmar Senha'),
                obscureText: true,
                validator: (value) => value != _senhaController.text ? 'As senhas não coincidem' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aqui, ajuste para chamar o método correto de cadastro com os dados coletados
                    apiService.handleCadastro(
                      _loginController.text,
                      _senhaController.text,
                      _tipoContaSelecionada, // Note que agora usamos o tipo de conta selecionado
                      _nomeController.text,
                      _cpfController.text,
                      context,
                    );
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _nomeController.dispose();
    _cpfController.dispose();
    super.dispose();
  }
}
