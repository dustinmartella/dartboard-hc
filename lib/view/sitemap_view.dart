import 'package:flutter/material.dart';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/blocs/sitemap_bloc.dart';
import 'package:dartboardhc/models/sitemap.dart';
import 'package:dartboardhc/view/restbloc_view.dart';

class GetSitemap extends StatefulWidget {
  @override
  _GetSitemapState createState() => _GetSitemapState();
}

class _GetSitemapState extends State<GetSitemap> {
	SitemapBloc _bloc;

	@override
	void initState() {
		super.initState();
		_bloc = SitemapBloc("systeminfo");
	}

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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
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
							onTap: () => Navigator.pop(context, false),
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

