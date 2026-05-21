import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, List<Map<String, dynamic>>>(
      (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  FavoritesNotifier() : super([]);

  void toggle(Map<String, dynamic> institute) {
    final exists = state.any((e) => e['name'] == institute['name']);

    if (exists) {
      state = state.where((e) => e['name'] != institute['name']).toList();
    } else {
      state = [...state, institute];
    }
  }

  void remove(String name) {
    state = state.where((e) => e['name'] != name).toList();
  }
}