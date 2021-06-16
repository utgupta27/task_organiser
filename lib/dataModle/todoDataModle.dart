final String tableTodos = 'todos';

class TodoFields {
  static final List<String> values = [
    id,
    title,
    subtitle,
    priority,
    dueDate,
    date
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String subtitle = 'subtitle';
  static final String priority = 'priority';
  static final String dueDate = 'dueDate';
  static final String date = 'date';
}

class Todo {
  final int? id;
  final String title;
  final String subtitle;
  final String priority;
  final String dueDate;
  final String date;

  const Todo({
    this.id,
    required this.title,
    required this.subtitle,
    required this.priority,
    required this.dueDate,
    required this.date,
  });

  Todo copy({
    int? id,
    String? title,
    String? subtitle,
    String? priority,
    String? dueDate,
    String? date,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      date: date ?? this.date,
    );
  }

  static Todo fromJson(Map<String, Object?> json) {
    return Todo(
      id: json[TodoFields.id] as int?,
      title: json[TodoFields.title] as String,
      subtitle: json[TodoFields.subtitle] as String,
      priority: json[TodoFields.priority] as String,
      dueDate: json[TodoFields.dueDate] as String,
      date: json[TodoFields.date] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      TodoFields.id: id,
      TodoFields.title: title,
      TodoFields.subtitle: subtitle,
      TodoFields.priority: priority,
      TodoFields.dueDate: dueDate,
      TodoFields.date: date,
    };
  }
}
