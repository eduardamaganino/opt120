import 'dart:convert';

import 'package:flutter/material.dart';
// Remove the unused import directive
import 'package:flutter_application_1/models/usuario.model.dart';
import 'package:flutter_application_1/user-task/user-task-create.dart';
import 'package:flutter_application_1/user-task/user-task-edit.dart';
import 'package:flutter_application_1/user/user-create.dart';
import 'package:flutter_application_1/user/user-edit.dart';
import 'package:http/http.dart' as http;

class UserTaskList extends StatefulWidget {
  @override
  _UserTaskListState createState() => _UserTaskListState();
}

class _UserTaskListState extends State<UserTaskList> {
  List<dynamic> usersTasks = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/showUserAtv'));

    if (response.statusCode == 200) {
      setState(() {
        usersTasks = jsonDecode(response.body);
        print(usersTasks);
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: usersTasks.length,
        itemBuilder: (context, index) {
          final userAtv = usersTasks[index];
          final usuarioId = userAtv['usuarioId'];
          final atividadeId = userAtv['atividadeId'];

          return ListTile(
            title: Text(usuarioId),
            subtitle: Text(atividadeId),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserTaskWidget(
                            usuarioId: usuarioId, atividadeId: atividadeId),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    // Send delete request to the backend
                    final response = await http.delete(Uri.parse(
                        'http://localhost:3000/deleteUserAtv/$usuarioId/$atividadeId'));
                    if (response.statusCode == 200) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('UserTask deleted successfully'),
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
                            content: Text('Failed to delete userAtv'),
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
            MaterialPageRoute(builder: (context) => CreateUserTaskWidget()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
