import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/todo_provider.dart';

final categories = ['All', 'Work', 'Personal', 'Shopping', 'Other'];

class CategoryFilter extends ConsumerStatefulWidget {
  const CategoryFilter({super.key});

  @override
  ConsumerState<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends ConsumerState<CategoryFilter> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });

              if (category == 'All') {
                ref.read(todoListProvider.notifier).resetFilter();
              } else {
                ref.read(todoListProvider.notifier).filterByCategory(category);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
