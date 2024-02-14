import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'screens/cadastrar_usuario_screen.dart';
import 'screens/dieta/dieta_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/perfil/perfil_screen.dart';
import 'screens/treino/treino_screen.dart';
import 'screens/treino/cadastrar_exercicio_screen.dart';
import 'screens/treino/cadastrar_treino_screen.dart';
import 'screens/perfil/editar_usuario_screen.dart';
import './screens/treino/detalhar_treino_musculacao_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(), // Inicializa o AuthProvider
      child: MyApp(),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blueGrey, // Cor da barra de navegação
    systemNavigationBarIconBrightness: Brightness.light, // Brilho dos ícones da barra de navegação
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return authProvider.isAuthenticated ? MainScreen() : LoginScreen();
        },
      ),
      routes: {
        '/main': (context) => MainScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => MainScreen(),
        '/treino': (context) => TreinoScreen(),
        '/dieta': (context) => DietaScreen(),
        '/perfil': (context) => PerfilScreen(),
        '/cadastrarUsuario': (context) => CadastroUsuario(),

        '/exercicio/cadastrar': (context) => CadastrarExercicioScreen(),
        '/treino/cadastrar': (context) => CadastrarTreinoScreen(),

        //'/treino/detalhar/musculacao': (context) => DetalharTreinoMusculacaoScreen(new Treino),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
  
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _widgetOptions = [
    HomeScreen(),
    TreinoScreen(),
    DietaScreen(),
    PerfilScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepOrange,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Treino',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Dieta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
