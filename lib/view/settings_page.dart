import 'package:flutter/material.dart';

import 'package:dartboardhc/config_controller.dart';
import 'package:dartboardhc/view/settings_configuration_view.dart';
import 'package:dartboardhc/view/settings_preferences_view.dart';


class SettingsPage extends StatefulWidget {
	final ConfigController configController;

	const SettingsPage({Key key, this.configController}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

	@override
	void initState() {
		super.initState();
	}

	@override
	void dispose() {
		super.dispose();
	}

  @override
  Widget build(BuildContext context) {
		final ConfigController configController = widget.configController;

		List<SettingsPageView> settingsPageViews = <SettingsPageView>[];

		settingsPageViews.add(
			SettingsPageView(
				title: 'Preferences',
				view: SettingsPreferencesView(configController: configController),
			)
		);

		if (configController.showConfig) {
			settingsPageViews.add(
				SettingsPageView(
					title: 'Configuration',
					view: SettingsConfigurationView(configController: configController),
				)
			);
		}

		return DefaultTabController(
			length: settingsPageViews.length,
			child: Scaffold(
				appBar: AppBar(
					title: const Text('Settings'),
					automaticallyImplyLeading: true,
					leading: IconButton(icon:Icon(Icons.arrow_back),
						onPressed: () => Navigator.pop(context, false),
					),
					actions: [
						IconButton(
							icon: Icon(configController.showConfig ? Icons.lock_open : Icons.lock),
							onPressed: () => ConfigController.of(context).setShowConfig(!configController.showConfig),
						),
					],
					bottom: TabBar(
						tabs: settingsPageViews.map((SettingsPageView p) {
							return Tab(
								child: Text(p.title),
							);
						}).toList(),
					),
				),
				body: TabBarView(
					children: settingsPageViews.map((SettingsPageView p) {
						return Container(
								child: p.view,
							);
					}).toList(),
				),
			),
		);
  }
}

class SettingsPageView {
  final String title;
  final Widget view;

  const SettingsPageView({this.title, this.view});
}

