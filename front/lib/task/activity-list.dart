import 'dart:convert';

import 'package:flutter/material.dart';
// Remove the unused import directive
import 'package:flutter_application_1/models/usuario.model.dart';
import 'package:flutter_application_1/task/activity-create.dart';
import 'package:flutter_application_1/task/activity-edit.dart';
import 'package:http/http.dart' as http;

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('http://localhost:3000/showAtv'));

    if (response.statusCode == 200) {
      setState(() {
        tasks = jsonDecode(response.body);
        print(tasks);
      });
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          final titulo = task['titulo'].toString();
          final descricao = task['descricao'].toString();

          return ListTile(
            title: Text(titulo),
            subtitle: Text(descricao),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskWidget(
                            atvId: task[
                                'id']), // Substitua 'id' pelo campo correto se necessário
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    // Send delete request to the backend
                    final response = await http.delete(Uri.parse(
                        'http://localhost:3000/deleteAtv/${task['id']}'));
                    if (response.statusCode == 200) {
                      // If the server returns a 200 OK response,
                      // display a success alert
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Task deleted successfully'),
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
                      // If the server did not return a 200 OK response,
                      // display an error alert
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to delete task'),
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
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskWidget()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
