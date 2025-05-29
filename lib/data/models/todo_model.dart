class TodoModel {
  final int id;
  final String title;
  final String description;
  final String category;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
    };
  }
}
