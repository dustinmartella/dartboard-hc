import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dartboardhc/theme_controller.dart';
import 'package:dartboardhc/view/home_view.dart';
import 'package:dartboardhc/view/sitemap_view.dart';

void main() async {
	final localPrefs = await SharedPreferences.getInstance();
	final themeController = ThemeController(localPrefs);

	runApp(HomeApp(localPrefs: localPrefs, themeController: themeController));
}

class HomeApp extends StatelessWidget {
	final SharedPreferences localPrefs;
	final ThemeController themeController;

	const HomeApp({Key key, this.localPrefs, this.themeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
			animation: themeController,
			builder: (context, _) {
				return ThemeControllerProvider(
					controller: themeController,
					child: MaterialApp(
						title: 'Home Control',
						theme: ThemeData(
							primarySwatch: Colors.blue,
							visualDensity: VisualDensity.adaptivePlatformDensity,
						),
						darkTheme: ThemeData.dark(),
						themeMode: _getThemeMode(),
						routes: <String, WidgetBuilder>{

							'/': (BuildContext context) {
								return MyHomePage(localPrefs: localPrefs, title: 'Dartboard');
							},

							'/board': (BuildContext context) {
								return Scaffold(
									appBar: AppBar(
										title: const Text('Board'),
										automaticallyImplyLeading: true,
										leading: IconButton(icon:Icon(Icons.arrow_back),
											onPressed:() => Navigator.pop(context, false),
										),
									),
									body: GetSitemap(),
								);
							},

							'/settings': (BuildContext context) {
								return Scaffold(
									appBar: AppBar(
										title: const Text('Settings'),
										automaticallyImplyLeading: true,
										leading: IconButton(icon:Icon(Icons.arrow_back),
											onPressed: () => Navigator.pop(context, false),
										),
									),
									body: ListView(
											children: <Widget>[
												ListTile(
													leading: Icon(themeController.themeMode == 'dark' ? Icons.brightness_low : Icons.brightness_auto),
													onTap: () => ThemeController.of(context).setTheme(themeController.themeMode != 'dark' ? 'dark' : 'system'),
													title: const Text('Enforce Dark Mode'),
													trailing: Switch(
														value: (themeController.themeMode == 'dark'),
														onChanged: (bool value) => ThemeController.of(context).setTheme(value ? 'dark' : 'system'),
													),
												),
												ListTile(
													leading: Icon(themeController.themeMode == 'light' ? Icons.brightness_high : Icons.brightness_auto),
													onTap: () => ThemeController.of(context).setTheme(themeController.themeMode != 'light' ? 'light' : 'system'),
													title: const Text('Enforce Light Mode'),
													trailing: Switch(
														value: (themeController.themeMode == 'light'),
														onChanged: (bool value) => ThemeController.of(context).setTheme(value ? 'light' : 'system'),
													),
												),
												/*
												RaisedButton(
													onPressed: () => ThemeController.of(context).setTheme('dark'),
													child: const Text('Dark Theme'),
												),
												RaisedButton(
													onPressed: () => ThemeController.of(context).setTheme('system'),
													child: const Text('System'),
												),
												*/
											],
									),
								);
							},
						}
					),
				);
			},
		);
  }

	ThemeMode _getThemeMode() {
		switch (themeController.themeMode) {
			case 'dark':
				return ThemeMode.dark;
			case 'light':
				return ThemeMode.light;
			default:
				return ThemeMode.system;
		}
	}
}



