import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/atividade.model.dart';
import 'package:flutter_application_1/models/usuario.model.dart';
import 'package:flutter_application_1/task/activity-list.dart';
import 'package:flutter_application_1/user-task/user-task-list.dart';
import 'package:flutter_application_1/user/user-create.dart';
import 'package:flutter_application_1/user/user-list.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OPT120'),
        backgroundColor: Colors.pink.shade200,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _SampleCard(
                cardName: 'User', backgroundColor: Colors.pink.shade100),
            _SampleCard(
                cardName: 'Task', backgroundColor: Colors.pink.shade100),
            _SampleCard(
                cardName: 'UserTask', backgroundColor: Colors.pink.shade100),
          ],
        ),
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName, required this.backgroundColor});
  final String cardName;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cardName == 'User') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserList()),
          );
        }
        if (cardName == 'Task') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskList()),
          );
        }
        if (cardName == 'UserTask') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserTaskList()),
          );
        }
      },
      child: Card(
        color: backgroundColor,
        child: Container(
          width: 600,
          height: 100,
          child: Center(child: Text(cardName)),
        ),
      ),
    );
  }
}
