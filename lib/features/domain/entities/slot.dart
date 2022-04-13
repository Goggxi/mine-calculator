const String tableSlot = 'slot';

class SlotFields {
  static final List<String> values = [id, title, createAt];

  static const String id = '_id';
  static const String type = 'type';
  static const String title = 'title';
  static const String createAt = 'create_at';
}

class Slot {
  final int? id;
  final String type;
  final String title;
  final DateTime createdAt;
  Slot({
    this.id,
    required this.type,
    required this.title,
    required this.createdAt,
  });

  Slot copyWith({
    int? id,
    String? type,
    String? title,
    DateTime? createdAt,
  }) {
    return Slot(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static Slot fromJson(Map<String, Object?> json) => Slot(
        id: json[SlotFields.id] as int?,
        type: json[SlotFields.type] as String,
        title: json[SlotFields.title] as String,
        createdAt: DateTime.parse(json[SlotFields.createAt] as String),
      );

  Map<String, Object?> toJson() => {
        SlotFields.id: id,
        SlotFields.type: type,
        SlotFields.title: title,
        SlotFields.createAt: createdAt.toIso8601String(),
      };
}
