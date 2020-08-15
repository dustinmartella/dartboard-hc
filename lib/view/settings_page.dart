import 'package:flutter/material.dart';

import 'package:dartboardhc/config_controller.dart';

class SettingsPage extends StatelessWidget {
	final ConfigController configController;

	const SettingsPage({Key key, this.configController}) : super(key: key);

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
							leading: Icon(configController.themeMode == 'dark' ? Icons.brightness_low : Icons.brightness_auto),
							onTap: () => ConfigController.of(context).setTheme(configController.themeMode != 'dark' ? 'dark' : 'system'),
							title: const Text('Enforce Dark Mode'),
							trailing: Switch(
								value: (configController.themeMode == 'dark'),
								onChanged: (bool value) => ConfigController.of(context).setTheme(value ? 'dark' : 'system'),
							),
						),
						ListTile(
							leading: Icon(configController.themeMode == 'light' ? Icons.brightness_high : Icons.brightness_auto),
							onTap: () => ConfigController.of(context).setTheme(configController.themeMode != 'light' ? 'light' : 'system'),
							title: const Text('Enforce Light Mode'),
							trailing: Switch(
								value: (configController.themeMode == 'light'),
								onChanged: (bool value) => ConfigController.of(context).setTheme(value ? 'light' : 'system'),
							),
						),
						const Divider(),
						const Text("OpenHAB URL"),
						const Text("Username"),
						const Text("Password"),
						const Text("Default Sitemap"),
						const Text("Single Sitemap Mode"),
					],
			),
		);
  }
}
