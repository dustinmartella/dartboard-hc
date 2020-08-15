import 'package:flutter/material.dart';

import 'package:dartboardhc/models/sitemap.dart';

class DartboardView extends StatelessWidget {
  final Sitemap sitemap;

  const DartboardView({Key key, this.sitemap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		if (sitemap.homepage.widgets != null) {
			return new ListView.builder(
				itemCount: sitemap.homepage.widgets.length,
				shrinkWrap: true,
				physics: const AlwaysScrollableScrollPhysics(),
				//scrollDirection: Axis.horizontal,
				itemBuilder: (context, index) {
					return HabWidgetView(
							habWidget: sitemap.homepage.widgets[index],
						);
				},
			);
		} else {
			return Text(sitemap.homepage.title);
		}
  }
}

class HabWidgetView extends StatelessWidget {
	final HabWidget habWidget;

	const HabWidgetView({Key key, @required this.habWidget}) : super(key: key);

	@override
  Widget build(BuildContext context) {
		switch (habWidget.type) {
			case 'Frame':
				return HabWidgetViewFrame(habWidget: habWidget);
			case 'Text':
				return HabWidgetViewText(habWidget: habWidget);
			default:
				return Text(habWidget.type);
		}
	}
}

class HabWidgetViewFrame extends StatelessWidget {
	final HabWidget habWidget;

	const HabWidgetViewFrame({Key key, @required this.habWidget}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return
			Center(
				child: Card(
					elevation: 5,
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: <Widget>[
							Text(habWidget.label),
							ListView.builder(
									itemCount: habWidget.widgets.length,
									shrinkWrap: true,
									itemBuilder: (context, index) {
										return HabWidgetView(
												habWidget: habWidget.widgets[index],
											);
									}
							)
						],
					),
				),
			);
	}
}

class HabWidgetViewText extends StatelessWidget {
	final HabWidget habWidget;

	const HabWidgetViewText({Key key, @required this.habWidget}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return
			ListTile(
				leading: Icon(Icons.message),
				title: Text(habWidget.label),
				//onTap: () => Navigator.pop(context, false),
			);
	}
}

