import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dartboardhc/view/home_view.dart';
import 'package:dartboardhc/view/sitemaps_list_view.dart';
import 'package:dartboardhc/view/sitemap_view.dart';

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
								onPressed:() => Navigator.pop(context, false),
							),
						),
						body: GetSitemaps(),
					);
				},

			}
    );
  }
}

