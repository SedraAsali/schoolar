import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, List<Map<String, dynamic>>>(
      (ref) => FavoritesNotifier(),
);

class FavoritesNotifier
    extends StateNotifier<List<Map<String, dynamic>>> {

  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  static const String _storageKey = 'favorites';

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final String? savedData = prefs.getString(_storageKey);

    if (savedData != null) {
      final List decoded = jsonDecode(savedData);

      state = decoded
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _storageKey,
      jsonEncode(state),
    );
  }

  Future<void> toggle(Map<String, dynamic> institute) async {
    final exists =
    state.any((e) => e['name'] == institute['name']);

    if (exists) {
      state = state
          .where((e) => e['name'] != institute['name'])
          .toList();
    } else {
      state = [...state, institute];
    }

    await _saveFavorites();
  }

  Future<void> remove(String name) async {
    state = state
        .where((e) => e['name'] != name)
        .toList();

    await _saveFavorites();
  }

  Future<void> add(Map<String, dynamic> institute) async {
    final exists =
    state.any((e) => e['name'] == institute['name']);

    if (!exists) {
      state = [...state, institute];

      await _saveFavorites();
    }
  }

  Future<void> clear() async {
    state = [];

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}