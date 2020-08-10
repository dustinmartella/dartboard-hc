import 'dart:async';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/repository/sitemaps_repository.dart';
import 'package:dartboardhc/models/sitemap.dart';

class SitemapsBloc {
  SitemapsRepository _sitemapsRepository;
  StreamController _sitemapsListController;

  StreamSink<RestResponse<Sitemaps>> get sitemapsListSink =>
      _sitemapsListController.sink;

  Stream<RestResponse<Sitemaps>> get sitemapsListStream =>
      _sitemapsListController.stream;

  SitemapsBloc() {
    _sitemapsListController = StreamController<RestResponse<Sitemaps>>();
    _sitemapsRepository = SitemapsRepository();
    fetchSitemaps();
  }

  fetchSitemaps() async {
    sitemapsListSink.add(RestResponse.loading('Requesting Sitemaps.'));

    try {
      Sitemaps sitemaps =
				await _sitemapsRepository.fetchSitemapsData();
      sitemapsListSink.add(RestResponse.completed(sitemaps));
    } catch (e) {
      sitemapsListSink.add(RestResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _sitemapsListController?.close();
  }
}
