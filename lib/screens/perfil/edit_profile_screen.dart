import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/usuario.dart';

class EditProfileScreen extends StatefulWidget {
  final ValueNotifier<Usuario> usuarioNotifier;

  EditProfileScreen({required this.usuarioNotifier});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nomeController;
  late TextEditingController _idadeController;
  late TextEditingController _alturaController;
  late TextEditingController _pesoController;
  late TextEditingController _nivelAtividadeController;
  late TextEditingController _objetivoController;

  File? _image; // Variável para armazenar a imagem selecionada

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.usuarioNotifier.value.nome);
    _idadeController = TextEditingController(text: widget.usuarioNotifier.value.idade.toString());
    _alturaController = TextEditingController(text: widget.usuarioNotifier.value.altura.toString());
    _pesoController = TextEditingController(text: widget.usuarioNotifier.value.peso.toString());
    _nivelAtividadeController = TextEditingController(text: widget.usuarioNotifier.value.nivelAtividade);
    _objetivoController = TextEditingController(text: widget.usuarioNotifier.value.objetivo);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _alturaController.dispose();
    _pesoController.dispose();
    _nivelAtividadeController.dispose();
    _objetivoController.dispose();
    super.dispose();
  }

  Future<void> getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Nenhuma imagem selecionada.');
      }
    });
  }

  void _updateProfile() {
    Usuario currentUser = widget.usuarioNotifier.value;

    Usuario updatedUser = Usuario(
      nome: _nomeController.text,
      idade: int.parse(_idadeController.text),
      altura: double.parse(_alturaController.text),
      peso: double.parse(_pesoController.text),
      nivelAtividade: _nivelAtividadeController.text,
      objetivo: _objetivoController.text,
      imagePath: _image?.path ?? currentUser.imagePath,
    );

    widget.usuarioNotifier.value = updatedUser;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _updateProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: getImage,
                child: Center(
                  child: _image == null
                      ? CircleAvatar(
                    radius: 70,
                    backgroundImage: widget.usuarioNotifier.value.imagePath != null
                        ? NetworkImage(widget.usuarioNotifier.value.imagePath!)
                        : null,
                    child: Icon(Icons.camera_alt, size: 30),
                  )
                      : CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(_image!),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _idadeController,
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _alturaController,
                decoration: InputDecoration(labelText: 'Altura (cm)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _pesoController,
                decoration: InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _nivelAtividadeController,
                decoration: InputDecoration(labelText: 'Nível de Atividade'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _objetivoController,
                decoration: InputDecoration(labelText: 'Objetivo'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile, // Chama o método de atualização quando pressionado.
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
