import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoApi {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // جلب كل المهام
  static Future<List<TodoModel>> fetchTodos() async {
    final url = Uri.parse('$baseUrl/todos');
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'FlutterApp/1.0', // ✅ مضاف لحل مشكلة 403
        },
      );

      print('🌐 API Response Code: ${response.statusCode}');
      print(
        '🌐 API Body: ${response.body.substring(0, 100)}',
      ); // أول 100 حرف فقط

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.take(20).map((json) {
          return TodoModel(
            id: json['id'],
            title: json['title'],
            description: 'Test Description', // مؤقت لأن الـ API ما بيرجعش وصف
            category: 'Work', // مؤقت لأن الـ API ما بيرجعش تصنيف
          );
        }).toList();
      } else {
        throw Exception('Failed to load todos: status ${response.statusCode}');
      }
    } catch (e) {
      print('🔥 Error occurred: $e');
      throw Exception('Failed to load todos');
    }
  }

  // إضافة مهمة جديدة
  static Future<bool> addTodo(TodoModel todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'FlutterApp/1.0', // ✅ مهم كمان هنا
      },
      body: json.encode(todo.toJson()),
    );

    return response.statusCode == 201;
  }
}
