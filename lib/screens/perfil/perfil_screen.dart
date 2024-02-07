import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/token_service.dart';
import '../../models/usuario.dart';
import '../login_screen.dart';
import 'edit_profile_screen.dart';

class PerfilScreen extends StatefulWidget {
  late final ValueNotifier<Usuario> usuarioNotifier;

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final TokenService _tokenService = TokenService();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    widget.usuarioNotifier.addListener(_onUsuarioUpdated);
    _checkTokenValidity();
  }

  void _onUsuarioUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _checkTokenValidity() async {
    String? token = await _tokenService.getToken();
    setState(() {
      _isLoggedIn = token != null && token.isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.usuarioNotifier.removeListener(_onUsuarioUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        leading: Icon(Icons.person, color: Colors.amber[900]),
        title: Text("Perfil", style: TextStyle(color: Colors.amber[900])),
      ),
      body: _isLoggedIn ? _buildUserProfile() : _buildLoginPrompt(),
    );
  }

  Widget _buildUserProfile() {
    Usuario usuario = widget.usuarioNotifier.value;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildUserAvatar(usuario),
          SizedBox(height: 20),
          _buildUserInfo(usuario),
          SizedBox(height: 20),
          _buildEditProfileButton(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(Usuario usuario) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: CircleAvatar(
        radius: 70,
        backgroundImage: usuario.imagePath != null ? FileImage(File(usuario.imagePath!)) : null,
        child: usuario.imagePath == null ? Icon(Icons.person, size: 100, color: Colors.white) : null,
      ),
    );
  }

  Widget _buildUserInfo(Usuario usuario) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _userInfoTile(Icons.person, 'Nome', usuario.nome),
            _userInfoTile(Icons.cake, 'Idade', '${usuario.idade} anos'),
            _userInfoTile(Icons.height, 'Altura', '${usuario.altura} m'),
            _userInfoTile(Icons.monitor_weight, 'Peso', '${usuario.peso} kg'),
            _userInfoTile(Icons.directions_run, 'Nível de Atividade', usuario.nivelAtividade),
            _userInfoTile(Icons.flag, 'Objetivo', usuario.objetivo),
          ],
        ),
      ),
    );
  }

  ListTile _userInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildEditProfileButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(usuarioNotifier: widget.usuarioNotifier),
            ),
          );
        },
        child: Text('Editar Perfil', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Faça login para ver o perfil'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
