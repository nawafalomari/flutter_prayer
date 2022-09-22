import 'dart:convert';

class Prayer {
  final DateTime time;
  final String title;
  Prayer({
    required this.time,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'title': title,
    };
  }

  factory Prayer.fromMap(Map<String, dynamic> map) {
    return Prayer(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Prayer.fromJson(String source) => Prayer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Prayer(time: $time, title: $title)';

  @override
  bool operator ==(covariant Prayer other) {
    if (identical(this, other)) return true;

    return other.time == time && other.title == title;
  }

  @override
  int get hashCode => time.hashCode ^ title.hashCode;

  Prayer copyWith({
    DateTime? time,
    String? title,
  }) {
    return Prayer(
      time: time ?? this.time,
      title: title ?? this.title,
    );
  }
}
