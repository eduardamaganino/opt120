import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/user/user-edit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserPageWidget extends StatefulWidget {
  @override
  _UserPageWidgetState createState() => _UserPageWidgetState();
}

class _UserPageWidgetState extends State<UserPageWidget> {
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _getUserIDFromLocalStorage();
  }

  Future<void> _getUserIDFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId != null) {
      int userIdInt = userId;
      // Se o ID do usuário estiver disponível no Local Storage, chame _fetchUser com esse ID
      await _fetchUser(userIdInt);
    } else {
      print('User ID not found in Local Storage');
    }
  }

  Future<void> _fetchUser(int userId) async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/showUserId/${userId}'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        setState(() {
          _user = jsonData;
          print(_user!['nome']);
        });
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name: ${_user!['nome']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink, // Definindo a cor do título
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${_user!['email']}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserWidget(
                            userId: _user!['id'],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Edit User',
                      style: TextStyle(
                        color: Colors.pink, // Definindo a cor do botão
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(0, 255, 255,
                          255), // Faz o fundo do botão transparente
                      shadowColor:
                          Colors.transparent, // Remove a sombra do botão
                    ),
                  ),
                  // Adicione mais informações do perfil do usuário aqui
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
