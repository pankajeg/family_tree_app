import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationState<T> {
  const PaginationState({
    required this.items,
    required this.currentPage,
    required this.pageSize,
    required this.hasMore,
    required this.isInitialLoading,
    required this.isLoadingMore,
    required this.isRefreshing,
    this.error,
    this.totalCount,
  });

  factory PaginationState.initial({
    int initialPage = 1,
    int pageSize = 20,
  }) {
    return PaginationState<T>(
      items: <T>[],
      currentPage: initialPage - 1,
      pageSize: pageSize,
      hasMore: true,
      isInitialLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
    );
  }

  final List<T> items;
  final int currentPage;
  final int pageSize;
  final bool hasMore;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool isRefreshing;
  final Object? error;
  final int? totalCount;

  bool get isBusy => isInitialLoading || isLoadingMore || isRefreshing;

  PaginationState<T> copyWith({
    List<T>? items,
    int? currentPage,
    int? pageSize,
    bool? hasMore,
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    Object? error,
    bool clearError = false,
    int? totalCount,
  }) {
    return PaginationState<T>(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: clearError ? null : (error ?? this.error),
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

class PageResult<T> {
  const PageResult({
    required this.items,
    required this.hasMore,
    this.totalCount,
  });

  final List<T> items;
  final bool hasMore;
  final int? totalCount;
}

abstract class PaginationViewModel<T> extends Notifier<PaginationState<T>> {
  int get initialPage => 1;

  int get pageSize => 20;

  @override
  PaginationState<T> build() {
    return PaginationState<T>.initial(
      initialPage: initialPage,
      pageSize: pageSize,
    );
  }

  bool get isBusy => state.isBusy;

  bool get isRefreshing => state.isRefreshing;

  bool get isLoadingMore => state.isLoadingMore;

  List<T> get items => state.items;

  Future<PageResult<T>> fetchPage({
    required int page,
    required int pageSize,
  });

  Future<void> loadInitial() async {
    if (state.isInitialLoading) {
      return;
    }

    state = state.copyWith(
      isInitialLoading: true,
      clearError: true,
    );

    try {
      final result = await fetchPage(page: initialPage, pageSize: state.pageSize);
      state = state.copyWith(
        items: result.items,
        currentPage: initialPage,
        hasMore: result.hasMore,
        totalCount: result.totalCount,
        isInitialLoading: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        isInitialLoading: false,
        error: error,
      );
    }
  }

  Future<void> refresh() async {
    if (state.isRefreshing || state.isInitialLoading) {
      return;
    }

    state = state.copyWith(
      isRefreshing: true,
      clearError: true,
    );

    try {
      final result = await fetchPage(page: initialPage, pageSize: state.pageSize);
      state = state.copyWith(
        items: result.items,
        currentPage: initialPage,
        hasMore: result.hasMore,
        totalCount: result.totalCount,
        isRefreshing: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        isRefreshing: false,
        error: error,
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.isInitialLoading || state.isRefreshing || !state.hasMore) {
      return;
    }

    state = state.copyWith(
      isLoadingMore: true,
      clearError: true,
    );

    final nextPage = state.currentPage + 1;

    try {
      final result = await fetchPage(page: nextPage, pageSize: state.pageSize);
      state = state.copyWith(
        items: <T>[...state.items, ...result.items],
        currentPage: nextPage,
        hasMore: result.hasMore,
        totalCount: result.totalCount,
        isLoadingMore: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        isLoadingMore: false,
        error: error,
      );
    }
  }

  void reset() {
    state = PaginationState<T>.initial(
      initialPage: initialPage,
      pageSize: pageSize,
    );
  }
}
