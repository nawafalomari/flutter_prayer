import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_flutter/golabal_providers.dart';

class HomeController {
  final WidgetRef _ref;

  HomeController({required WidgetRef ref}) : _ref = ref;

  void onForwardClick() {
    _ref.read(dateProvider.state).state = _ref.read(dateProvider).add(const Duration(days: 1));
  }

  void onBackwardClick() {
    _ref.read(dateProvider.state).state = _ref.read(dateProvider).add(const Duration(days: -1));
  }
}
