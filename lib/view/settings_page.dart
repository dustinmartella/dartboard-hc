import 'package:flutter/material.dart';

import 'package:dartboardhc/config_controller.dart';


class SettingsPage extends StatefulWidget {
	final ConfigController configController;

	const SettingsPage({Key key, this.configController}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
	final _baseUrlController = TextEditingController();
	final _usernameController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
	void dispose() {
		_baseUrlController.dispose();
		_usernameController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

  @override
  Widget build(BuildContext context) {
		_baseUrlController.text = widget.configController.baseUrl;
		_usernameController.text = widget.configController.username;
		_passwordController.text = widget.configController.password;

		return DefaultTabController(
			length: 2,
			child: Scaffold(
				appBar: AppBar(
					title: const Text('Settings'),
					automaticallyImplyLeading: true,
					leading: IconButton(icon:Icon(Icons.arrow_back),
						onPressed: () => Navigator.pop(context, false),
					),
					bottom: TabBar(
						tabs: [
							Tab(
								text: 'Preferences',
							),
							Tab(
								text: 'Configuration',
							),
						],
					),
				),
				body: TabBarView(
					children: [
							ListView(
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
							),

							ListView(
								children: <Widget>[
									ListTile(
										leading: const Icon(Icons.phone),
										title: TextField(
												controller: _baseUrlController,
												onSubmitted: (baseUrl) => widget.configController.setBaseUrl(baseUrl),
												decoration: InputDecoration(
													hintText: "Base URL",
												),
											),
									),

									ListTile(
										leading: const Icon(Icons.phone),
										title: TextField(
												controller: _usernameController,
												onSubmitted: (username) => widget.configController.setUsername(username),
												decoration: InputDecoration(
													hintText: "Username",
												),
											),
									),

									ListTile(
										leading: const Icon(Icons.phone),
										title: TextField(
												obscureText: true,
												controller: _passwordController,
												onSubmitted: (password) => widget.configController.setPassword(password),
												decoration: InputDecoration(
													hintText: "Password",
												),
											),
									),

									const Text("Default Sitemap"),
									const Text("Single Sitemap Mode"),
								],
							),
					],
				),
			),
		);
  }
}
