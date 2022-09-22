import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_flutter/domain/models/prayter_day.dart';
import 'package:prayer_flutter/domain/repos/prayer_repo.dart';

final prayersProviderProvider = FutureProvider<PrayerDay>((ref) async {
  return ref.read(prayerRepoProvider).getPrayersForDayCity(ref.watch(dateProvider), 'Dammam');
});

final dateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
