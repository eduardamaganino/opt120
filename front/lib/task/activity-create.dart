import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/atividade.model.dart';
// Remove the unused import directive
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa o pacote intl para formatar datas

class CreateTaskWidget extends StatefulWidget {
  @override
  _CreateTaskWidgetState createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  String titulo = '';
  String descricao = '';
  String nota = '';
  String data_atv = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        data_atv = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Titulo',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 40,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  setState(() {
                    titulo = value;
                  });
                },
              ),
            ),
            SizedBox(height: 15),
            const Text(
              'Descricao',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 40,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  setState(() {
                    descricao = value;
                  });
                },
              ),
            ),
            SizedBox(height: 15),
            const Text(
              'Nota',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 40,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  setState(() {
                    nota = value;
                  });
                },
              ),
            ),
            SizedBox(height: 15),
            const Text(
              'Data da atividade',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 40,
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(text: data_atv),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(double.infinity, 40),
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Colors.pink.shade400,
              ),
              onPressed: () async {
                final task = Task(titulo, descricao, nota, data_atv);

                final response = await http.post(
                  Uri.parse('http://localhost:3000/newAtv'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'titulo': titulo,
                    'descricao': descricao,
                    'nota': nota,
                    'data_atv': data_atv
                  }),
                );
                if (response.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Parabens!'),
                        content: Text('Atividade criada com sucesso'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Erro ao criar tarefa'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }

                // Your onPressed logic
              },
              child: const Text('Criar'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Create Task Example',
    home: CreateTaskWidget(),
  ));
}
