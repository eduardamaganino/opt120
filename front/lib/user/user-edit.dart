import 'dart:convert';

import 'package:flutter/material.dart';
// Remove the unused import directive
import 'package:flutter_application_1/models/usuario.model.dart';
import 'package:flutter_application_1/user/user-create.dart';
import 'package:http/http.dart' as http;

class EditUserWidget extends StatefulWidget {
  final int userId;

  EditUserWidget({required this.userId});

  @override
  _EditUserWidgetState createState() => _EditUserWidgetState();
}

class _EditUserWidgetState extends State<EditUserWidget> {
  String nome = '';
  String email = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  nome = value;
                });
              },
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  senha = value;
                });
              },
            ),
            const SizedBox(height: 10), // Add some spacing
            ElevatedButton(
              onPressed: () async {
                final user = User(nome, email, senha);
                // TODO: Implement logic to create user
                final response = await http.put(
                  Uri.parse(
                      'http://localhost:3000/updateUser/${widget.userId}'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'nome': nome,
                    'email': email,
                    'senha': senha,
                  }),
                );

                if (response.statusCode == 200) {
                  // If the server returns a 200 OK response,
                  // then parse the JSON.
                  print('User edited successfully');
                } else {
                  // If the server did not return a 200 OK response,
                  // then throw an exception.
                  throw Exception('Failed to edit user');
                }
              },
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
