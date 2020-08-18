import 'package:flutter/material.dart';

import 'package:dartboardhc/config_controller.dart';

class SettingsPreferencesView extends StatefulWidget {
	final ConfigController configController;

	const SettingsPreferencesView({Key key, this.configController}) : super(key: key);

	@override
	_SettingsPreferencesViewState createState() => _SettingsPreferencesViewState();
}

class _SettingsPreferencesViewState extends State<SettingsPreferencesView>{

	@override
	Widget build(BuildContext context) {
		return ListView(
								children: <Widget>[
									ListTile(
										leading: Icon(widget.configController.themeMode == 'dark' ? Icons.brightness_low : Icons.brightness_auto),
										onTap: () => ConfigController.of(context).setTheme(widget.configController.themeMode != 'dark' ? 'dark' : 'system'),
										title: const Text('Enforce Dark Mode'),
										trailing: Switch(
											value: (widget.configController.themeMode == 'dark'),
											onChanged: (bool value) => ConfigController.of(context).setTheme(value ? 'dark' : 'system'),
										),
									),
									ListTile(
										leading: Icon(widget.configController.themeMode == 'light' ? Icons.brightness_high : Icons.brightness_auto),
										onTap: () => ConfigController.of(context).setTheme(widget.configController.themeMode != 'light' ? 'light' : 'system'),
										title: const Text('Enforce Light Mode'),
										trailing: Switch(
											value: (widget.configController.themeMode == 'light'),
											onChanged: (bool value) => ConfigController.of(context).setTheme(value ? 'light' : 'system'),
										),
									),
								],
							);
	}
}
