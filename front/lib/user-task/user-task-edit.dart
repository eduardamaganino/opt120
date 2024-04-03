import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/atividade.model.dart';
import 'package:flutter_application_1/models/usuario-atividade.model.dart';
// Remove the unused import directive
import 'package:flutter_application_1/models/usuario.model.dart';
import 'package:http/http.dart' as http;

class EditUserTaskWidget extends StatefulWidget {
  final int usuarioId;
  final int atividadeId;

  EditUserTaskWidget({required this.usuarioId, required this.atividadeId});

  @override
  _EditUserTaskWidgetState createState() => _EditUserTaskWidgetState();
}

class _EditUserTaskWidgetState extends State<EditUserTaskWidget> {
  int usuarioId = 0;
  int atividadeId = 0;
  String nota = '';
  String entrega = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit UserTask'),
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
              onPressed: () async {
                final userTask =
                    UserTask(usuarioId, atividadeId, entrega, nota);
                final response = await http.put(
                  Uri.parse(
                      'http://localhost:3000/updateUserAtv/${widget.usuarioId}/${widget.atividadeId}'),
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
                  // If the server returns a 200 OK response,
                  // then parse the JSON.
                  print('UserTask edited successfully');
                } else {
                  // If the server did not return a 200 OK response,
                  // then throw an exception.
                  throw Exception('Failed to edit usertask');
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
