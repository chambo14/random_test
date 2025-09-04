import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

class ListUserState {
  final List<dynamic> results;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;

  ListUserState({
    this.results = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
  });

  ListUserState copyWith({
    List<dynamic>? results,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
  }) {
    return ListUserState(
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// ---- NOTIFIER ----
class ListUserNotifier extends StateNotifier<ListUserState> {
  ListUserNotifier(this._repo) : super(ListUserState());

  final ApiService _repo;

  Future<void> fetchUser({bool refresh = false}) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final page = refresh ? 1 : state.currentPage;
      final result = await _repo.fetchUserContact(state.currentPage + 1, results: 50);

      final normalList = result?.results ?? [];
      state = ListUserState(
        results: refresh ? normalList : [...state.results, ...normalList],
        isLoading: false,
        hasMore: normalList.isNotEmpty,
        currentPage: page + 1,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

/// ---- PROVIDER ----
final userProvider =
StateNotifierProvider<ListUserNotifier, ListUserState>(
      (ref) => ListUserNotifier(ApiService()),
);
