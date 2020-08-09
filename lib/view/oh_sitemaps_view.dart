import 'package:flutter/material.dart';

import 'package:dartboardhc/blocs/oh_sitemap_bloc.dart';
import 'package:dartboardhc/rest/rest_repsonse.dart';
import 'package:dartboardhc/models/oh_sitemap.dart';

class GetSitemaps extends StatefulWidget {
  @override
  _GetSitemapsState createState() => _GetSitemapsState();
}

class _GetSitemapsState extends State<GetSitemaps> {
	OhSitemapBloc _bloc;

	@override
	void initState() {
		super.initState();
		_bloc = OhSitemapBloc();
	}

	@override
	Widget build(BuildContext context) {
		return
      RefreshIndicator(
        onRefresh: () => _bloc.fetchSitemaps(),
        child: StreamBuilder<RestResponse<Sitemaps>>(
          stream: _bloc.ohSitemapListStream,
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
			physics: ClampingScrollPhysics(),
    );
  }
}


class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
