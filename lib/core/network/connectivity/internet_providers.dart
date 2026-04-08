import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'internet_service.dart';

final internetServiceProvider = Provider<InternetService>((ref) {
  return InternetService();
});

final internetStatusProvider = StreamProvider<bool>((ref) {
  return ref.watch(internetServiceProvider).onStatusChange;
});
