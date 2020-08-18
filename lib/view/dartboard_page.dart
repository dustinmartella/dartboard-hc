import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dartboardhc/blocs/homepage_bloc.dart';
import 'package:dartboardhc/models/sitemap.dart';
import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/view/restbloc_view.dart';
import 'package:dartboardhc/view/time_view.dart';
import 'package:dartboardhc/view/dartboard_drawer.dart';
import 'package:dartboardhc/view/dartboard_view.dart';

class DartboardPage extends StatefulWidget {
  final String title;

  DartboardPage({Key key, this.title}) : super(key: key);

  @override
  _DartboardPageState createState() => _DartboardPageState();
}

class _DartboardPageState extends State<DartboardPage> {
	Sitemap _sitemap;
	Homepage _homepage;
	HomepageBloc _homepageBloc;

	@override
	void initState() {
		super.initState();
		_sitemap = new Sitemap();
		_homepage = new Homepage();
		_homepageBloc = new HomepageBloc(_homepage.link);
	}

  @override
  void dispose() {
		_homepageBloc.dispose();
    super.dispose();
  }

	void _switchSitemap(Sitemap sitemap) async {
    setState(() {
      _sitemap = sitemap;
    });

		_switchHomepage(_sitemap.homepage);
	}

	void _switchHomepage(Homepage homepage) async {
    setState(() {
      _homepage = homepage;
			_homepageBloc = HomepageBloc(_homepage.link);
    });
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_homepage.title ?? _sitemap.label ?? widget.title),
				actions: [
					Center(
						child: TimeView(),
					),

					PopupMenuButton<String>(
						onSelected: (String r) => Navigator.pushNamed(context, r),
						itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
							const PopupMenuItem<String>(
								value: "/board",
								child: ListTile(
									leading: Icon(Icons.api),
									title: const Text('Board'),
								),
							),
							const PopupMenuItem<String>(
								value: "/settings",
								child: ListTile(
									leading: Icon(Icons.settings),
									title: const Text('Settings'),
								),
							),
						],
					),
				],
      ),
			drawer: DartboardDrawer(
					title: widget.title,
					onSelected: _switchSitemap,
					currentSitemap: _sitemap,
					currentHomepage: _homepage,
				),
      body: RefreshIndicator(
        onRefresh: () => _homepageBloc.fetchHomepage(),
        child: StreamBuilder<RestResponse<Homepage>>(
          stream: _homepageBloc.homepageListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
											loadingMessage: snapshot.data.message
										);
                case Status.COMPLETED:
                  return DartboardView(
											homepage: snapshot.data.data,
											onSelected: _switchHomepage,
										);
                case Status.ERROR:
                  return Error(
											errorMessage: snapshot.data.message,
											onRetryPressed: () => _homepageBloc.fetchHomepage(),
										);
								default:
									return Container();
              }
            } else {
							return Container();
						}
          },
        ),
      ),

    );
  }
}

