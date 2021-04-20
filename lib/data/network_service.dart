import 'dart:convert';

import 'package:http/http.dart' as http;

final baseUrl = 'http://localhost:3000/';

class NetworkService {
  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/todos'));
      print(response.body);
      return jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      await http.patch(Uri.parse(baseUrl + 'todos/$id'), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map> addTodo(Map<String, String> todoObj) async {
    try {
      final reponse =
          await http.post(Uri.parse(baseUrl + 'todos'), body: todoObj);
      print(reponse.body);
      return jsonDecode(reponse.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await http.delete(Uri.parse(baseUrl + 'todos/$id'));
      return true;
    } catch (e) {
      return false;
    }
  }
}
