import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shared base class for async MVVM view models.
abstract class BaseViewModel<T> extends AsyncNotifier<T> {
  bool get isBusy => state.isLoading;

  bool get isRefreshing => state.isRefreshing;

  bool get hasError => state.hasError;

  Object? get error => state.error;

  T? get dataOrNull => state.valueOrNull;

  /// Runs an async action and updates [state] with loading/data/error states.
  Future<void> execute(Future<T> Function() action) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => action());
  }

  /// Runs an async action while preserving previous data state semantics.
  Future<void> executeRefresh(Future<T> Function() action) async {
    state = await AsyncValue.guard(() => action());
  }

  /// Runs an async action, then returns the computed value.
  Future<T?> executeAndGet(Future<T> Function() action) async {
    await execute(action);
    return dataOrNull;
  }

  /// Sets a successful value explicitly.
  void setData(T data) {
    state = AsyncData<T>(data);
  }

  /// Sets an error state explicitly.
  void setError(Object error, StackTrace stackTrace) {
    state = AsyncError<T>(error, stackTrace);
  }
}
