import 'package:flutter/material.dart';

import 'package:dartboardhc/theme_controller.dart';

class SettingsPage extends StatelessWidget {
	final ThemeController themeController;

	const SettingsPage({Key key, this.themeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
						const Divider(),
						ListTile(
							leading: Icon(Icons.home),
							trailing: TextField(),
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
  }
}
