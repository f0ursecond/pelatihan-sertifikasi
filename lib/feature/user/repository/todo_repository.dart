import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pelatihan_sertifikasi/model/todo_model.dart';

class TodoRepository {
  final String baseUrl = 'https://691405fcf34a2ff1170ddd6e.mockapi.io/api/v1/todos';

  Future<List<TodoModel>> getTodo() async {
    final response = await http.get(Uri.parse(baseUrl));

    switch (response.statusCode) {
      case 200:
        return (json.decode(response.body) as List).map((e) => TodoModel.fromJson(e)).toList();
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: ${response.body}');
      case 403:
        throw Exception('Forbidden: ${response.body}');
      case 404:
        throw Exception('Not found: ${response.body}');
      case 500:
        throw Exception('Internal server error: ${response.body}');
      default:
        throw Exception('Failed to load todos: ${response.statusCode} ${response.body}');
    }
  }

  Future<TodoModel> createTodo(TodoModel todo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    switch (response.statusCode) {
      case 201:
      case 200:
        return TodoModel.fromJson(json.decode(response.body));
      default:
        throw Exception('Failed to create todo: ${response.statusCode} ${response.body}');
    }
  }

  Future<TodoModel> updateTodo(String id, TodoModel todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        return TodoModel.fromJson(json.decode(response.body));
      case 404:
        throw Exception('Todo not found: ${response.body}');
      default:
        throw Exception('Failed to update todo: ${response.statusCode} ${response.body}');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    switch (response.statusCode) {
      case 200:
      case 204:
        return;
      case 404:
        throw Exception('Todo not found: ${response.body}');
      default:
        throw Exception('Failed to delete todo: ${response.statusCode} ${response.body}');
    }
  }
}
