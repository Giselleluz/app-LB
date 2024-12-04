import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiController extends ChangeNotifier {
  final String baseUrl =
      'https://9b2427c5-ff0a-41b5-82b5-d4d152cda757-00-2utlbc55e5ahg.picard.replit.dev/users'; // Altere para o URL da sua API

  String? username;
  ApiController() {
    _loadUsername();
    _loadEmail();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    notifyListeners();
  }

  void setUsername(String name) async {
    username = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    notifyListeners();
  }

  String? getUserName() {
    return username;
  }

  String? email;

  void _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    notifyListeners();
  }

  void setEmail(String usuarioemail) async {
    email = usuarioemail;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', usuarioemail);
    notifyListeners();
  }

  String? getEmail() {
    return email;
  }

  Future<bool> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      setUsername(responseBody['username']);
      setEmail(responseBody['email']);
      print('ffffffffff ${responseBody['email']}');
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      throw Exception(responseBody['message'] ?? 'Erro desconhecido');
    }
  }

  Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setUsername(responseBody['username']);
      setEmail(responseBody['email']);
      print('ffffffffff ${responseBody['email']}');
      print('ba dgebcyrbcyb ${username}');
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['message'] ?? 'Erro desconhecido');
    }
  }
}
