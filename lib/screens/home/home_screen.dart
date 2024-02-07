import 'package:flutter/material.dart';

import '../../models/usuario.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const Color myBlueGrey800 = Color(0xFF37474F);

  late final ValueNotifier<Usuario> usuarioNotifier;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    usuarioNotifier = ValueNotifier<Usuario>(
      Usuario(
        nome: 'Nome do Usuário',
        idade: 30,
        altura: 1.75,
        peso: 70.5,
        nivelAtividade: 'Ativo',
        objetivo: 'Manter a forma', imagePath: null,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
