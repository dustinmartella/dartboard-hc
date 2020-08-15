import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dartboardhc/config_controller.dart';
import 'package:dartboardhc/view/dartboard_page.dart';
import 'package:dartboardhc/view/board_page.dart';
import 'package:dartboardhc/view/settings_page.dart';

void main() async {
	final localPrefs = await SharedPreferences.getInstance();
	final configController = ConfigController(localPrefs);

	runApp(HomeApp(configController: configController));
}

class HomeApp extends StatelessWidget {
	final ConfigController configController;
	final String title = 'Dartboard';

	const HomeApp({Key key, this.configController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
			animation: configController,
			builder: (context, _) {
				return ConfigControllerProvider(
					controller: configController,
					child: MaterialApp(
						title: title,
						theme: ThemeData(
							primarySwatch: Colors.blue,
							visualDensity: VisualDensity.adaptivePlatformDensity,
						),
						darkTheme: ThemeData.dark(),
						themeMode: _getThemeMode(),
						routes: <String, WidgetBuilder>{

							'/': (BuildContext context) {
								return DartboardPage(title: title);
							},

							'/board': (BuildContext context) {
								return BoardPage();
							},

							'/settings': (BuildContext context) {
								return SettingsPage(configController: configController);
							},
						}
					),
				);
			},
		);
  }

	ThemeMode _getThemeMode() {
		switch (configController.themeMode) {
			case 'dark':
				return ThemeMode.dark;
			case 'light':
				return ThemeMode.light;
			default:
				return ThemeMode.system;
		}
	}
}



