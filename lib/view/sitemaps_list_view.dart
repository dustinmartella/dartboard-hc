import 'package:flutter/material.dart';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/blocs/sitemaps_bloc.dart';
import 'package:dartboardhc/models/sitemap.dart';
import 'package:dartboardhc/view/restbloc_view.dart';

class GetSitemaps extends StatefulWidget {
  @override
  _GetSitemapsState createState() => _GetSitemapsState();
}

class _GetSitemapsState extends State<GetSitemaps> {
	SitemapsBloc _bloc;

	@override
	void initState() {
		super.initState();
		_bloc = SitemapsBloc();
	}

	@override
	Widget build(BuildContext context) {
		return
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
                  return SitemapsList(sitemapsList: snapshot.data.data);
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
      );
	}

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}


class SitemapsList extends StatelessWidget {
  final Sitemaps sitemapsList;

  const SitemapsList({Key key, this.sitemapsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
			itemBuilder: (context, index) {
				return
					ListTile(
						leading: Icon(Icons.message),
						title: Text(sitemapsList.sitemaps[index].label),
						onTap: () => Navigator.pop(context, false),
					);
			},
			itemCount: sitemapsList.sitemaps.length,
			shrinkWrap: true,
			physics: const AlwaysScrollableScrollPhysics(),
    );
  }
}

