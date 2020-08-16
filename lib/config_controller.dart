import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// provides the currently selected theme, saves changed theme preferences to disk
class ConfigController extends ChangeNotifier {
  static const themePrefKey = 'theme';
	static const baseUrlPrefKey = 'baseurl';
	static const usernamePrefKey = 'username';
	static const passwordPrefKey = 'password';

  final SharedPreferences _prefs;
  String _themeMode;
	String _baseUrl;
	String _username;
	String _password;

	// construct props from shared preferences
  ConfigController(this._prefs) {
    _themeMode = _prefs.getString(themePrefKey) ?? 'system';
		_baseUrl = _prefs.getString(baseUrlPrefKey) ?? 'http://openhab';
		_username = _prefs.getString(usernamePrefKey) ?? null;
		_password = _prefs.getString(passwordPrefKey) ?? null;
  }

  // get the current theme
  String get themeMode => _themeMode;

	// get the current base url
	String get baseUrl => _baseUrl;

	// get the usename
	String get username => _username;

	// get the password
	String get password => _password;

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

	// set username
	void setUsername(String username) {
		_username = username;
		notifyListeners();
		_prefs.setString(usernamePrefKey, username);
	}

	// set password
	void setPassword(String password) {
		_password = password;
		notifyListeners();
		_prefs.setString(passwordPrefKey, password);
	}

  /// get the controller from any page of your app
  static ConfigController of(BuildContext context) {
    final ConfigControllerProvider provider = context.dependOnInheritedWidgetOfExactType<ConfigControllerProvider>();
    return provider.controller;
  }
}

/// provides the theme controller to any page of your app
class ConfigControllerProvider extends InheritedWidget {
  const ConfigControllerProvider({Key key, this.controller, Widget child}) : super(key: key, child: child);

  final ConfigController controller;

  @override
  bool updateShouldNotify(ConfigControllerProvider old) => controller != old.controller;
}
