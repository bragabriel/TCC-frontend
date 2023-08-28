import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:string_validator/string_validator.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    secondNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void updateUserEmail(String email) {
    // Bater na API de PUT de Usuário passando o email novo
  }

  void updateUserFullName(String fullName) {
    // Bater na API de PUT de Usuário passando o nome novo
  }

  void updateUserPhone(String phone) {
    // Bater na API de PUT de Usuário passando o telefone novo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Editar Email",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail.';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Seu e-mail'),
                controller: emailController,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      EmailValidator.validate(emailController.text)) {
                    updateUserEmail(emailController.text);
                  }
                },
                child: Text('Atualizar Email'),
              ),
              SizedBox(height: 20),
              Text(
                "Editar Nome",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu primeiro nome';
                  } else if (!isAlpha(value)) {
                    return 'Apenas letras, por favor!';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Primeiro nome'),
                controller: firstNameController,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu sobrenome';
                  } else if (!isAlpha(value)) {
                    return 'Apenas letras, por favor!';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Sobrenome'),
                controller: secondNameController,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      isAlpha(firstNameController.text +
                          secondNameController.text)) {
                    updateUserFullName(firstNameController.text +
                        " " +
                        secondNameController.text);
                  }
                },
                child: Text('Atualizar Nome'),
              ),
              SizedBox(height: 20),
              Text(
                "Editar Telefone",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número do seu celular';
                  } else if (isAlpha(value)) {
                    return 'Apenas números, por favor!';
                  } else if (value.length < 10) {
                    return 'Por favor, insira um número de telefone válido';
                  }
                  return null;
                },
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Seu número de celular'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      isNumeric(phoneController.text)) {
                    updateUserPhone(phoneController.text);
                  }
                },
                child: Text('Atualizar Telefone'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}