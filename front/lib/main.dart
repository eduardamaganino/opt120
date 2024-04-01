import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/atividade.model.dart';
import 'package:flutter_application_1/models/usuario.model.dart';
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
          ],
        ),
      ),
    );
  }
}

class CreateUserWidget extends StatefulWidget {
  @override
  _CreateUserWidgetState createState() => _CreateUserWidgetState();
}

class _CreateUserWidgetState extends State<CreateUserWidget> {
  String nome = '';
  String email = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
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
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink, // Set the text color
              ),
              onPressed: () async {
                final user = User(nome, email, senha);
                // TODO: Implement logic to create user

                final response = await http.post(
                  Uri.parse('http://localhost:3000/newUser'),
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
                  print('User created successfully');
                } else {
                  // If the server did not return a 200 OK response,
                  // then throw an exception.
                  throw Exception('Failed to create user');
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

class CreateTaskWidget extends StatefulWidget {
  @override
  _CreateTaskWidgetState createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  String titulo = '';
  String descricao = '';
  String nota = '';
  String dataAtv = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Titulo',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  titulo = value;
                });
              },
            ),
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  descricao = value;
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
            SizedBox(height: 10), // Add some spacing
            TextField(
              decoration: const InputDecoration(
                labelText: 'Data',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (value) {
                setState(() {
                  dataAtv = value;
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
                final task = Task(titulo, descricao, nota, dataAtv);
                // TODO: Implement logic to create user

                final response = await http.post(
                  Uri.parse('http://localhost:3000/novaTarefa'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'titulo': titulo,
                    'descricao': descricao,
                    'nota': nota,
                    'dataAtv': dataAtv,
                  }),
                );

                if (response.statusCode == 200) {
                  // If the server returns a 200 OK response,
                  // then parse the JSON.
                  print('User created successfully');
                } else {
                  // If the server did not return a 200 OK response,
                  // then throw an exception.
                  throw Exception('Failed to create user');
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

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/showUser'));

    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
        print(users);
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final nome = user['nome'].toString();
          final email = user['email'].toString();

          return ListTile(
            title: Text(nome),
            subtitle: Text(email),
          );
        },
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
            MaterialPageRoute(builder: (context) => CreateTaskWidget()),
          );
        }
      },
      child: Card(
        color: backgroundColor,
        child: Container(
          width: 600,
          height: 200,
          child: Center(child: Text(cardName)),
        ),
      ),
    );
  }
}
