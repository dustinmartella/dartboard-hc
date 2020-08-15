import 'package:flutter/material.dart';

import 'package:dartboardhc/blocs/sitemaps_bloc.dart';
import 'package:dartboardhc/models/sitemap.dart';
import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/view/restbloc_view.dart';

class DartboardDrawer extends StatefulWidget {
	final String title;
	final Function onSelected;
	final Sitemap currentSitemap;

	@override
	DartboardDrawer({Key key, @required this.title, @required this.onSelected, this.currentSitemap}) : super(key: key);

  @override
  _DartboardDrawerState createState() => _DartboardDrawerState();
}

class _DartboardDrawerState extends State<DartboardDrawer> {
	SitemapsBloc _bloc;

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
										widget.title,
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
												return SitemapsList(
														sitemapsList: snapshot.data.data,
														onSelected: widget.onSelected,
														currentSitemap: widget.currentSitemap,
													);
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
	final Sitemap currentSitemap;

  const SitemapsList({Key key, this.sitemapsList, @required this.onSelected, this.currentSitemap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
			itemBuilder: (context, index) {
				return
					ListTile(
						leading: Icon(sitemapsList.sitemaps[index] == currentSitemap ? Icons.radio_button_checked: Icons.radio_button_unchecked),
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
