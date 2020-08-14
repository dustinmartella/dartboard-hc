import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dartboardhc/theme_controller.dart';
import 'package:dartboardhc/view/home_view.dart';
import 'package:dartboardhc/view/sitemap_view.dart';
import 'package:dartboardhc/view/settings_page.dart';

void main() async {
	final localPrefs = await SharedPreferences.getInstance();
	final themeController = ThemeController(localPrefs);

	runApp(HomeApp(themeController: themeController));
}

class HomeApp extends StatelessWidget {
	final ThemeController themeController;
	final String title = 'Dartboard';

	const HomeApp({Key key, this.themeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
			animation: themeController,
			builder: (context, _) {
				return ThemeControllerProvider(
					controller: themeController,
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
								return MyHomePage(title: title);
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
								return SettingsPage(themeController: themeController);
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



