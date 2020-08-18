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
	List<SettingsPageView> settingsPageViews = <SettingsPageView>[];

	@override
	void initState() {
		super.initState();

		final ConfigController configController = widget.configController;

		settingsPageViews.add(
			SettingsPageView(
				title: 'Preferences',
				view: SettingsPreferencesView(configController: configController),
			)
		);

		settingsPageViews.add(
			SettingsPageView(
				title: 'Configuration',
				view: SettingsConfigurationView(configController: configController),
			)
		);
	}

	@override
	void dispose() {
		super.dispose();
	}

	void showConfig() {
    setState(() {
		});
	}

  @override
  Widget build(BuildContext context) {
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
							icon: const Icon(Icons.lock_open),
							onPressed: () {},
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

