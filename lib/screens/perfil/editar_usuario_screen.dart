import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/usuario.dart';
import '../../services/token_service.dart';
import '../../services/perfil_service.dart';
import '../../main.dart';

class EditarUsuarioScreen extends StatefulWidget {
  final Usuario usuario;

  EditarUsuarioScreen({required this.usuario});

  @override
  _EditarUsuarioScreenState createState() => _EditarUsuarioScreenState();
}

class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
  final TokenService _tokenService = TokenService();
  late TextEditingController _nomeController;
  late TextEditingController _cpfController;
  late TextEditingController _dataNascimentoController;
  late TextEditingController _alturaController;
  late TextEditingController _pesoAtualController;
  late Usuario _usuarioCopy;
  String _selectedNivelAtividade = 'Sedentário';
  String _selectedObjetivo = 'Perda de Peso';
  List<String> _niveisAtividade = ['SEDENTARIO', 'LEVE', 'MODERADO', 'INTENSO', 'MUITO_INTENSO'];
  List<String> _objetivos = ['PERDA_PESO', 'MANUTENCAO', 'GANHO_MASSA'];

  Future<String?> _getToken() async {
    return await _tokenService.getToken();
  }

  @override
  void initState() {
    super.initState();
    _usuarioCopy = widget.usuario;
    _nomeController = TextEditingController(text: _usuarioCopy.nome ?? '');
    _cpfController = TextEditingController(text: _usuarioCopy.cpf ?? '');
    _dataNascimentoController = TextEditingController(
      text: _usuarioCopy.dataNascimento != null ? DateFormat('dd/MM/yyyy').format(_usuarioCopy.dataNascimento!) : '',
    );
    _alturaController = TextEditingController(text: _usuarioCopy.altura?.toString() ?? '');
    _pesoAtualController = TextEditingController(text: _usuarioCopy.pesoAtual?.toString() ?? '');
    _selectedNivelAtividade = _usuarioCopy.nivelAtividade ?? 'Sedentário';
    _selectedObjetivo = _usuarioCopy.objetivo ?? 'Perda de Peso';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _dataNascimentoController.dispose();
    _alturaController.dispose();
    _pesoAtualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuário'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _dataNascimentoController,
              decoration: InputDecoration(labelText: 'Data de Nascimento'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _alturaController,
              decoration: InputDecoration(labelText: 'Altura'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _pesoAtualController,
              decoration: InputDecoration(labelText: 'Peso Atual'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedNivelAtividade,
              items: _niveisAtividade.map((nivel) {
                return DropdownMenuItem<String>(
                  value: nivel,
                  child: Text(nivel),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedNivelAtividade = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Nível de Atividade'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedObjetivo,
              items: _objetivos.map((objetivo) {
                return DropdownMenuItem<String>(
                  value: objetivo,
                  child: Text(objetivo),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedObjetivo = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Objetivo'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _salvarAlteracoes,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarAlteracoes() async {
    try {
      Usuario usuarioAtualizado = Usuario(
        nome: _nomeController.text,
        cpf: _cpfController.text,
        dataNascimento: DateFormat('dd/MM/yyyy').parse(_dataNascimentoController.text),
        altura: double.parse(_alturaController.text),
        pesoAtual: double.parse(_pesoAtualController.text),
        nivelAtividade: _selectedNivelAtividade,
        objetivo: _selectedObjetivo,
      );

      String? token = await _getToken();
      if (token != null) {
        await PerfilService().editarUsuario(token, usuarioAtualizado);

        // Retorne para a tela anterior
        Navigator.pop(context);

        // Recarregue os dados do usuário na tela de perfil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(), // Substitua "TelaPerfil" pelo nome da sua tela de perfil
          ),
        );
      } else {
        throw Exception('Erro: Token de autenticação não encontrado.');
      }
    } catch (error) {
      print('Erro ao editar o usuário: $error');
    }
  }
}
