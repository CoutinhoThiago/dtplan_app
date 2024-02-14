import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/usuario.dart';
import '../../services/perfil_service.dart';
import '../../services/token_service.dart';
import './editar_usuario_screen.dart'; // Importe a tela de edição de perfil

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late Future<Usuario> _userDataFuture;
  final TokenService _tokenService = TokenService();

  @override
  void initState() {
    super.initState();
    _userDataFuture = _loadUserData();
  }

  Future<Usuario> _loadUserData() async {
    final token = await _tokenService.getToken();
    final perfilService = PerfilService();
    return perfilService.getUsuario(token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        centerTitle: true,
      ),
      body: FutureBuilder<Usuario>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error.toString());
          } else {
            return _buildProfile(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildProfile(Usuario userData) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey[200],
                  // Se você tiver uma imagem de perfil, pode definir aqui
                  // backgroundImage: NetworkImage(userData.profileImageUrl),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: _buildUserDataTable(userData),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Usuario usuario = await _userDataFuture; // Obtenha o usuário do futuro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditarUsuarioScreen(usuario: usuario)),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 5),
                    Text('Editar Perfil'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildUserDataTable(Usuario userData) {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(1), // Para fazer as células se ajustarem ao conteúdo
        1: FlexColumnWidth(2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        _buildTableRow('Nome', userData.nome),
        _buildTableRow('CPF', userData.cpf),
        _buildTableRow('Data de Nascimento', DateFormat('dd/MM/yyyy').format(userData.dataNascimento)),
        _buildTableRow('Altura', '${userData.altura} cm'),
        _buildTableRow('Peso Atual', '${userData.pesoAtual} kg'),
        _buildTableRow('Nível de Atividade', userData.nivelAtividade),
        _buildTableRow('Objetivo', userData.objetivo),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        'Erro ao carregar os dados do usuário: $message',
        style: TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }
}
