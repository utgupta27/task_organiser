final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, title, subtitle, color, date];
  static final String id = '_id';
  static final String title = 'title';
  static final String subtitle = 'subtitle';
  static final String color = 'color';
  static final String date = 'date';
}

class Note {
  final int? id;
  final String title;
  final String subtitle;
  final String color;
  final String date;

  const Note({
    this.id,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.date,
  });

  Note copy({
    int? id,
    String? title,
    String? subtitle,
    String? color,
    String? date,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      color: color ?? this.color,
      date: date ?? this.date,
    );
  }

  static Note fromJson(Map<String, Object?> json) {
    return Note(
      id: json[NoteFields.id] as int?,
      title: json[NoteFields.title] as String,
      subtitle: json[NoteFields.subtitle] as String,
      color: json[NoteFields.color] as String,
      date: json[NoteFields.date] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      NoteFields.id: id,
      NoteFields.title: title,
      NoteFields.subtitle: subtitle,
      NoteFields.color: color,
      NoteFields.date: date,
    };
  }
}
