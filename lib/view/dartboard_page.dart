import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dartboardhc/blocs/sitemap_bloc.dart';
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
	SitemapBloc _bloc;

	@override
	void initState() {
		super.initState();
		_bloc = SitemapBloc(_sitemap != null ? _sitemap.link : 'https://openhab.martellaville.net/rest/sitemaps/nada');
	}

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

	void _switchSitemap(Sitemap sitemap) async {
    setState(() {
      _sitemap = sitemap;
			_bloc = SitemapBloc(_sitemap.link);
    });
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_sitemap != null ? _sitemap.label : widget.title),
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
									title: Text('Board'),
								),
							),
							const PopupMenuItem<String>(
								value: "/settings",
								child: ListTile(
									leading: Icon(Icons.settings),
									title: Text('Settings'),
								),
							),
						],
					),

					//IconButton(
					//	icon: const Icon(Icons.more_vert),
						//onPressed: () {_nextPage(1);},
					//),
				],
      ),
			drawer: DartboardDrawer(
					title: widget.title,
					onSelected: _switchSitemap,
					currentSitemap: _sitemap,
				),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchSitemap(),
        child: StreamBuilder<RestResponse<Sitemap>>(
          stream: _bloc.sitemapListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return DartboardView(sitemap: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchSitemap(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),

    );
  }
}


/*
class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.directions_car),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];
*/
