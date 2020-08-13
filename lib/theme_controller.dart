import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// provides the currently selected theme, saves changed theme preferences to disk
class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';

  ThemeController(this._prefs) {
    // load theme from preferences on initialization
    _themeMode = _prefs.getString(themePrefKey) ?? 'system';
  }

  final SharedPreferences _prefs;
  String _themeMode;

  /// get the current theme
  String get themeMode => _themeMode;

  void setTheme(String theme) {
    _themeMode = theme;

    // notify the app that the theme was changed
    notifyListeners();

    // store updated theme on disk
    _prefs.setString(themePrefKey, theme);
  }

  /// get the controller from any page of your app
  static ThemeController of(BuildContext context) {
    final ThemeControllerProvider provider = context.dependOnInheritedWidgetOfExactType<ThemeControllerProvider>();
    return provider.controller;
  }
}

/// provides the theme controller to any page of your app
class ThemeControllerProvider extends InheritedWidget {
  const ThemeControllerProvider({Key key, this.controller, Widget child}) : super(key: key, child: child);

  final ThemeController controller;

  @override
  bool updateShouldNotify(ThemeControllerProvider old) => controller != old.controller;
}
