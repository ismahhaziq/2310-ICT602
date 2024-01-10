class Task {
  final int id;
  final String title;
  final String description;
  final bool completed; // Ensure this is of type bool

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'] == 1, // Convert 1 (int) to true (bool)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed ? 1 : 0, // Convert true (bool) to 1 (int)
    };
  }
}
