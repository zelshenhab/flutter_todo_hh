import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/todo_model.dart';
import '../../data/datasources/todo_api.dart';

// ✅ الحالة الأساسية: لائحة المهام
final todoListProvider = StateNotifierProvider<TodoNotifier, AsyncValue<List<TodoModel>>>(
  (ref) => TodoNotifier(),
);

class TodoNotifier extends StateNotifier<AsyncValue<List<TodoModel>>> {
  TodoNotifier() : super(const AsyncLoading()) {
    loadTodos(); // تحميل البيانات عند الإنشاء
  }

  List<TodoModel> _allTodos = [];

  // تحميل المهام من السيرفر
  Future<void> loadTodos() async {
    try {
      final todos = await TodoApi.fetchTodos();
      _allTodos = todos;
      state = AsyncData(todos);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  // إضافة مهمة جديدة
  Future<void> addTodo(TodoModel todo) async {
    try {
      final success = await TodoApi.addTodo(todo);
      if (success) {
        _allTodos = [..._allTodos, todo];
        state = AsyncData(_allTodos);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  // فلترة حسب التصنيف
  void filterByCategory(String category) {
    final filtered = _allTodos.where((todo) => todo.category == category).toList();
    state = AsyncData(filtered);
  }

  // عرض الكل
  void resetFilter() {
    state = AsyncData(_allTodos);
  }
}
