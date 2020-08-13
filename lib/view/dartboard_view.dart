import 'package:flutter/material.dart';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/blocs/sitemap_bloc.dart';
import 'package:dartboardhc/models/sitemap.dart';
import 'package:dartboardhc/view/restbloc_view.dart';

class DartboardView extends StatefulWidget {
	Sitemap sitemap;

  @override
  _DartboardViewState createState() => _DartboardViewState(sitemap);

	DartboardView({Key key, this.sitemap}) : super(key: key);
}

class _DartboardViewState extends State<DartboardView> {
	Sitemap sitemap;
	SitemapBloc _bloc;

	@override
	_DartboardViewState(this.sitemap);

	@override
	void initState() {
		super.initState();
		_bloc = SitemapBloc(sitemap != null ? sitemap.link : 'https://openhab.martellaville.net/rest/sitemaps/nada');
	}

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

	/*
	void updateSitemap(Sitemap sitemap) {
		setState(() {
			_bloc = SitemapBloc(sitemap != null ? sitemap.name : 'nada');
		});
	}
	*/

	@override
	Widget build(BuildContext context) {
		return
      RefreshIndicator(
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

