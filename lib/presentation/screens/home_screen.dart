import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/todo_provider.dart';
import '../widgets/todo_card.dart';
import '../widgets/category_filter.dart';
import 'create_task_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoState = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          const CategoryFilter(), 

          Expanded(
            child: todoState.when(
              data: (todos) => todos.isEmpty
                  ? const Center(child: Text("No tasks available"))
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return TodoCard(todo: todos[index]); 
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
          );
        },
      ),
    );
  }
}
