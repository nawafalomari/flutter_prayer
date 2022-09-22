import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:prayer_flutter/domain/models/prayer.dart';

class PrayerDay {
  final DateTime date;
  final List<Prayer> prayers;

  static const prayersNameMap = {
    'Fajr': 'الفجر',
    'Dhuhr': "الظهر",
    "Asr": 'العصر',
    "Maghrib": "المغرب",
    "Isha": "العشاء",
    'Sunrise': "الشروق",
    'Sunset': "الغروب"
  };



  PrayerDay({
    required this.date,
    required this.prayers,
  });

  PrayerDay copyWith({
    DateTime? date,
    List<Prayer>? prayers,
  }) {
    return PrayerDay(
      date: date ?? this.date,
      prayers: prayers ?? this.prayers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'prayers': prayers.map((x) => x.toMap()).toList(),
    };
  }

  factory PrayerDay.fromMap(Map<String, dynamic> map) {
    final date = (map['date']['gregorian']['date'] as String).split('-');
    final day = int.parse(date[0]);
    final month = int.parse(date[1]);
    final year = int.parse(date[2]);
    return PrayerDay(
        date: DateTime(year, month, day),
        prayers: List.generate(prayersNameMap.length, (index) {
          final time = (map['timings'] as Map<String, dynamic>).values.toList()[index].split(' ').first.split(':');
          final hours = int.parse(time[0]);
          final minutes = int.parse(time[1]);
          return Prayer(
              time: DateTime(year, month, day, hours, minutes),
              title: prayersNameMap[(map['timings'] as Map<String, dynamic>).keys.toList()[index]] ?? '');
        }));
  }

  String toJson() => json.encode(toMap());

  factory PrayerDay.fromJson(String source) => PrayerDay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PrayerDay(date: $date, prayers: $prayers)';

  @override
  bool operator ==(covariant PrayerDay other) {
    if (identical(this, other)) return true;

    return other.date == date && listEquals(other.prayers, prayers);
  }

  @override
  int get hashCode => date.hashCode ^ prayers.hashCode;
}
