import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// provides the currently selected theme, saves changed theme preferences to disk
class ThemeController extends ChangeNotifier {
  static const themePrefKey = 'theme';
	static const baseUrlPrefKey = 'baseurl';

  final SharedPreferences _prefs;
  String _themeMode;
	String _baseUrl;

	// construct props from shared preferences
  ThemeController(this._prefs) {
    _themeMode = _prefs.getString(themePrefKey) ?? 'system';
		_baseUrl = _prefs.getString(baseUrlPrefKey) ?? 'http://openhab';
  }

  // get the current theme
  String get themeMode => _themeMode;

	// get the current base url
	String get baseUrl => _baseUrl;

	// set theme
  void setTheme(String theme) {
    _themeMode = theme;

    notifyListeners();

    _prefs.setString(themePrefKey, theme);
  }

	// set base url
	void setBaseUrl(String url) {
		_baseUrl = url;

		notifyListeners();

		_prefs.setString(baseUrlPrefKey, url);
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
