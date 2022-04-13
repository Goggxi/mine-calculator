const String tableTonage = 'tonage_table';

class TonageFields {
  static final List<String> values = [id, idType, dateTime, dum, grade, tonage];

  static const String id = '_id';
  static const String idType = 'id_type';
  static const String dateTime = 'date_time';
  static const String dum = 'dum';
  static const String grade = 'grade';
  static const String tonage = 'tonage';
}

class Tonage {
  final int? id;
  final int idType;
  final DateTime dateTime;
  final double dum;
  final double grade;
  final double tonage;
  Tonage({
    this.id,
    required this.idType,
    required this.dateTime,
    required this.dum,
    required this.grade,
    required this.tonage,
  });

  Tonage copyWith({
    int? id,
    int? idType,
    DateTime? dateTime,
    double? dum,
    double? grade,
    double? tonage,
  }) {
    return Tonage(
      id: id ?? this.id,
      idType: idType ?? this.idType,
      dateTime: dateTime ?? this.dateTime,
      dum: dum ?? this.dum,
      grade: grade ?? this.grade,
      tonage: tonage ?? this.tonage,
    );
  }

  static Tonage fromJson(Map<String, Object?> json) => Tonage(
        id: json[TonageFields.id] as int?,
        idType: json[TonageFields.idType] as int,
        dateTime: DateTime.parse(json[TonageFields.dateTime] as String),
        dum: json[TonageFields.dum] as double,
        grade: json[TonageFields.grade] as double,
        tonage: json[TonageFields.tonage] as double,
      );

  Map<String, Object?> toJson() => {
        TonageFields.id: id,
        TonageFields.idType: idType,
        TonageFields.dateTime: dateTime.toLocal().toIso8601String(),
        TonageFields.dum: dum,
        TonageFields.grade: grade,
        TonageFields.tonage: tonage,
      };
}
