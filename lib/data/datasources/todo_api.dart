import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoApi {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<TodoModel>> fetchTodos() async {
    final url = Uri.parse('$baseUrl/todos');
    try {
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json', 'User-Agent': 'FlutterApp/1.0'},
      );

      if (kDebugMode) {
        print('🌐 API Response Code: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('🌐 API Body: ${response.body.substring(0, 100)}');
      }

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.take(20).map((json) {
          return TodoModel(
            id: json['id'],
            title: json['title'],
            description: 'Test Description',
            category: 'Work',
          );
        }).toList();
      } else {
        throw Exception('Failed to load todos: status ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('🔥 Error occurred: $e');
      }
      throw Exception('Failed to load todos');
    }
  }

  static Future<bool> addTodo(TodoModel todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'FlutterApp/1.0',
      },
      body: json.encode(todo.toJson()),
    );

    return response.statusCode == 201;
  }
}
