import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dartboardhc/view/time_view.dart';

import 'package:dartboardhc/blocs/sitemaps_bloc.dart';
import 'package:dartboardhc/blocs/sitemap_bloc.dart';
import 'package:dartboardhc/models/sitemap.dart';
import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/view/restbloc_view.dart';

class MyHomePage extends StatefulWidget {
  final String title;
	final SharedPreferences localPrefs;

  MyHomePage({Key key, this.localPrefs, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
			_bloc = SitemapBloc(_sitemap != null ? _sitemap.link : 'https://openhab.martellaville.net/rest/sitemaps/nada');
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
					//	tooltip: '',
						//onPressed: () {_nextPage(1);},
					//),
				],
      ),
			drawer: DartboardDrawer( onSelected: _switchSitemap ),
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
                  return SitemapBoard(sitemap: snapshot.data.data);
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






class SitemapBoard extends StatelessWidget {
  final Sitemap sitemap;

  const SitemapBoard({Key key, this.sitemap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		if (sitemap.homepage.widgets != null) {
			return new ListView.builder(
				itemBuilder: (context, index) {
					return
						ListTile(
							leading: Icon(Icons.message),
							title: Text(sitemap.homepage.widgets[index].label),
							//onTap: () => Navigator.pop(context, false),
						);
				},
				itemCount: sitemap.homepage.widgets.length,
				shrinkWrap: true,
				physics: const AlwaysScrollableScrollPhysics(),
			);
		} else {
			return Text(sitemap.homepage.title);
		}
  }
}






class DartboardDrawer extends StatefulWidget {
	final Function onSelected;

	@override
	DartboardDrawer({Key key, @required this.onSelected}) : super(key: key);

  @override
  _DartboardDrawerState createState() => _DartboardDrawerState(onSelected);
}

class _DartboardDrawerState extends State<DartboardDrawer> {
	final Function onSelected;
	SitemapsBloc _bloc;

	@override
	_DartboardDrawerState(this.onSelected);

	@override
	void initState() {
		super.initState();

		_bloc = SitemapsBloc();
	}

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
				child: ListView(
					padding: EdgeInsets.zero,
					children: <Widget>[

						DrawerHeader(
								decoration: BoxDecoration(
										color: Colors.blue,
								),
								child: Text(
										'Sites',
										style: TextStyle(
												color: Colors.white,
												fontSize: 24,
										),
								),
						),

						ListTile(
								leading: Icon(Icons.home),
								title: Text('Home'),
						),

						const Divider(),

						RefreshIndicator(
							onRefresh: () => _bloc.fetchSitemaps(),
							child: StreamBuilder<RestResponse<Sitemaps>>(
								stream: _bloc.sitemapsListStream,
								builder: (context, snapshot) {
									if (snapshot.hasData) {
										switch (snapshot.data.status) {
											case Status.LOADING:
												return Loading(loadingMessage: snapshot.data.message);
												break;
											case Status.COMPLETED:
												return SitemapsList(sitemapsList: snapshot.data.data, onSelected: onSelected);
												break;
											case Status.ERROR:
												return Error(
													errorMessage: snapshot.data.message,
													onRetryPressed: () => _bloc.fetchSitemaps(),
												);
												break;
										}
									}
									return Container();
								},
							),
						),

					],
				),
    );
  }
}


class SitemapsList extends StatelessWidget {
	final Function onSelected;
  final Sitemaps sitemapsList;

  const SitemapsList({Key key, this.sitemapsList, @required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
			itemBuilder: (context, index) {
				return
					ListTile(
						leading: Icon(Icons.message),
						title: Text(sitemapsList.sitemaps[index].label),
						onTap: () { Navigator.of(context).pop(); onSelected(sitemapsList.sitemaps[index]); },
					);
			},
			itemCount: sitemapsList.sitemaps.length,
			shrinkWrap: true,
			physics: const AlwaysScrollableScrollPhysics(),
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
