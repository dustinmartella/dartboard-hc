import 'package:flutter/material.dart';

import 'package:dartboardhc/config_controller.dart';

class SettingsConfigurationView extends StatefulWidget {
	final ConfigController configController;

	const SettingsConfigurationView({Key key, this.configController}) : super(key: key);

	@override
	_SettingsConfigurationViewState createState() => _SettingsConfigurationViewState();
}

class _SettingsConfigurationViewState extends State<SettingsConfigurationView> {
	final _baseUrlController = TextEditingController();
	final _usernameController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
	void initState() {
		super.initState();

		_baseUrlController.text = widget.configController.baseUrl;
		_usernameController.text = widget.configController.username;
		_passwordController.text = widget.configController.password;
	}

	@override
	void dispose() {
		_baseUrlController.dispose();
		_usernameController.dispose();
		_passwordController.dispose();

		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return ListView(
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
							);
	}
}
