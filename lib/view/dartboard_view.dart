import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:dartboardhc/models/sitemap.dart';

class DartboardView extends StatelessWidget {
  final Homepage homepage;
	final Function onSelected;

  const DartboardView({Key key, @required this.homepage, @required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		if (homepage.widgets != null) {
			return new ListView.builder(
				itemCount: homepage.widgets.length,
				shrinkWrap: true,
				physics: const AlwaysScrollableScrollPhysics(),
				//scrollDirection: Axis.horizontal,
				itemBuilder: (context, index) {
					return HabWidgetView(
							habWidget: homepage.widgets[index],
							onSelected: onSelected,
						);
				},
			);
		} else {
			return Text(homepage.title);
		}
  }
}

class HabWidgetView extends StatelessWidget {
	final HabWidget habWidget;
	final Function onSelected;

	const HabWidgetView({Key key, @required this.habWidget, @required this.onSelected}) : super(key: key);

	@override
  Widget build(BuildContext context) {
		if (habWidget.linkedPage != null) {
			return HabWidgetViewLink(habWidget: habWidget, onSelected: onSelected);
		}

		switch (habWidget.type) {
			case 'Frame':
				return HabWidgetViewFrame(habWidget: habWidget, onSelected: onSelected);
			case 'Text':
				return HabWidgetViewText(habWidget: habWidget, onSelected: onSelected);
			default:
				return Text(habWidget.type);
		}
	}
}

class HabWidgetViewLink extends StatelessWidget {
	final HabWidget habWidget;
	final Function onSelected;

	const HabWidgetViewLink({Key key, @required this.habWidget, @required this.onSelected}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return
			ListTile(
				leading: HabWidgetViewIcon(habWidget.icon),
				title: Text(habWidget.label),
				onTap: () => onSelected(habWidget.linkedPage),
			);
	}
}

class HabWidgetViewFrame extends StatelessWidget {
	final HabWidget habWidget;
	final Function onSelected;

	const HabWidgetViewFrame({Key key, @required this.habWidget, @required this.onSelected}) : super(key: key);

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
												onSelected: onSelected,
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
	final Function onSelected;

	const HabWidgetViewText({Key key, @required this.habWidget, @required this.onSelected}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return
			ListTile(
				leading: HabWidgetViewIcon(habWidget.icon),
				title: Text(habWidget.label),
				onTap: () {},
			);
	}
}

class HabWidgetViewIcon extends StatelessWidget {
	final String baseurl = 'https://openhab.martellaville.net';
	final String username = 'martellaville';
	final String password = 'foxtrotuniform77';
	final String icon;

	const HabWidgetViewIcon(this.icon, {Key key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		String basicAuth =
			'Basic ' + base64Encode(utf8.encode('$username:$password'));

		Map<String, String> imgHeaders = {
			'authorization': basicAuth,
		};

		String imgParams = 'state=UNDEF\&format=png\&anyFormat=true';

		String imgUrl = baseurl + '/icon/' + icon + '\?' + imgParams;

		return Container(
			margin: const EdgeInsets.all(0),
			width: 32.0,
			height: 32.0,
			//child: Center(
				child: Image(
					fit: BoxFit.fitWidth,
					image: NetworkImage(
						imgUrl,
						headers: imgHeaders,
					),
				),
			//),
		);
	}
}

