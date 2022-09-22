import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_flutter/domain/models/prayter_day.dart';
import 'package:prayer_flutter/domain/repos/prayer_repo.dart';

///
/// This provider will get the prayers time from the api
///
final prayersProviderProvider = FutureProvider.family<PrayerDay, DateTime>((ref, date) async {
  /// TODO: remove the hardcoded Dammam when the city name feature is impelmented
  return ref.read(prayerRepoProvider).getPrayersForDayCity(date, 'Dammam');
});

///
/// This provider will hold the state of the selected day
/// and when this provider is changed the [preyerProviderProvider]
/// will change as wll.
///
final dateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
