import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_flutter/constants/url_contants.dart';
import 'package:prayer_flutter/domain/models/prayter_day.dart';
import 'package:http/http.dart' as http;

/// A provider to access the repo
final prayerRepoProvider = Provider<PrayerRepo>((ref) {
  return PrayerRepo();
});

class PrayerRepo {
  Future<PrayerDay> getPrayersForDayCity(DateTime day, String cityName) async {
    try {
      final fullUrl = UrlConstants.prayerUrl
          .replaceFirst('cityName', cityName)
          .replaceFirst(
            'monthNumber',
            day.month.toString(),
          )
          .replaceFirst('yearNumber', day.year.toString());
      final prayersData = await http.get(Uri.parse(fullUrl));

      /// if success
      if (prayersData.statusCode == 200) {
        final decodedData = jsonDecode(prayersData.body);
        final prayerDay = PrayerDay.fromMap(decodedData['data'][day.day - 1]);
        return prayerDay;
      } else {
        throw Exception('No available data');
      }
    } catch (e) {
      log('$e');
      rethrow;
    }
  }
}
