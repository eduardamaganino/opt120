import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/atividade.model.dart';
import 'package:flutter_application_1/models/usuario-atividade.model.dart';
// Remove the unused import directive
import 'package:http/http.dart' as http;

class CreateUserTaskWidget extends StatefulWidget {
  @override
  _CreateUserTaskWidgetState createState() => _CreateUserTaskWidgetState();
}

class _CreateUserTaskWidgetState extends State<CreateUserTaskWidget> {
  int usuarioId = 0;
  int atividadeId = 0;
  String nota = '';
  String entrega = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create UserTask'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'UsuarioID',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  usuarioId = value as int;
                });
              },
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: const InputDecoration(
                labelText: 'AtividadeId',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  atividadeId = value as int;
                });
              },
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: const InputDecoration(
                labelText: 'Entrega',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  entrega = value;
                });
              },
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nota',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  nota = value;
                });
              },
            ),
            const SizedBox(height: 10), // Add some spacing
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink, // Set the text color
              ),
              onPressed: () async {
                final userTask =
                    UserTask(usuarioId, atividadeId, entrega, nota);

                final response = await http.post(
                  Uri.parse('http://localhost:3000/newUserAtv'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'usuarioId': usuarioId.toString(),
                    'atividadeId': atividadeId.toString(),
                    'entrega': entrega,
                    'nota': nota,
                  }),
                );

                if (response.statusCode == 200) {
                  print('User created successfully');
                } else {
                  throw Exception('Failed to create usertask');
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
