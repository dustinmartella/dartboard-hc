import 'dart:async';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/repository/homepage_repository.dart';
import 'package:dartboardhc/models/sitemap.dart';

class HomepageBloc {
	String homepageLink;
  HomepageRepository _homepageRepository;
  StreamController _homepageListController;

  StreamSink<RestResponse<Homepage>> get homepageListSink =>
      _homepageListController.sink;

  Stream<RestResponse<Homepage>> get homepageListStream =>
      _homepageListController.stream;

  HomepageBloc(String homepageLink) {
		this.homepageLink = homepageLink;

    _homepageListController = StreamController<RestResponse<Homepage>>();
    _homepageRepository = HomepageRepository();

    fetchHomepage();
  }

  fetchHomepage() async {
    homepageListSink.add(RestResponse.loading('Requesting Homepage.'));

    try {
      Homepage homepage =
				await _homepageRepository.fetchHomepageData(this.homepageLink);
      homepageListSink.add(RestResponse.completed(homepage));
    } catch (e) {
      homepageListSink.add(RestResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _homepageListController?.close();
  }
}
