import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './providers.dart';
import '../model/settings.dart';

class DisplayNotifier extends StateNotifier<DisplaySettings?> {
  DisplayNotifier(this.refs) : super(null);

  final SharedPreferences refs;
  static const String _name = 'displaySettings';

  Future init() async {
    final settingsString = refs.getString(_name);
    if (settingsString == null) {
      const settings = DisplaySettings(darkMode: false);
      await refs.setString(_name, jsonEncode(settings.toJson()));
      state = settings;
      return;
    }
    state = DisplaySettings.fromJson(jsonDecode(settingsString));
  }

  Future toggleDarkMode() async {
    if (state != null) {
      final bool darkMode = state?.darkMode ?? false;
      state = state?.copyWith(darkMode: !darkMode);
      await refs.setString(_name, jsonEncode(state?.toJson()));
    }
  }
}

final displaySettingsProvider =
    StateNotifierProvider<DisplayNotifier, DisplaySettings?>((ref) {
  final SharedPreferences refs = ref.read(sharedPreferencesProvider);
  final notifier = DisplayNotifier(refs);

  notifier.init();

  return notifier;
});

///
class NotificationNotifier extends StateNotifier<NotificationSettings?> {
  NotificationNotifier(this.refs) : super(null);

  final SharedPreferences refs;

  static const String _name = 'notificationSettings';

  Future init() async {
    final settingsString = refs.getString(_name);
    if (settingsString == null) {
      const settings = NotificationSettings(enabled: false, days: 1);
      await refs.setString('displaySettings', jsonEncode(settings.toJson()));
      state = settings;
      return;
    }
    state = NotificationSettings.fromJson(jsonDecode(settingsString));
  }
}

final notificationSettingsProvider =
    StateNotifierProvider<NotificationNotifier, NotificationSettings?>((ref) {
  final SharedPreferences refs = ref.read(sharedPreferencesProvider);
  final notifier = NotificationNotifier(refs);
  return notifier;
});
