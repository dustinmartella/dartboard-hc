import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:homefly/view/home_view.dart';
import 'package:homefly/view/chuck_categories_view.dart';

void main() => runApp(HomeApp());

class HomeApp extends StatelessWidget {
	static SharedPreferences localStorage;

	static Future init() async {
		localStorage = await SharedPreferences.getInstance();
	}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
			darkTheme: ThemeData.dark(),
			//themeMode: ThemeMode.dark,
			routes: <String, WidgetBuilder>{
				'/': (BuildContext context) {
					return MyHomePage(title: 'Dartboard');
				},

				'/chucky': (BuildContext context) {
					return GetChuckCategories();
				},

				'/settings': (BuildContext context) {
					return Scaffold(
						appBar: AppBar(
							title: const Text('Settings'),
						),
					);
				}
			}
    );
  }
}

