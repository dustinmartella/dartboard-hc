import 'dart:async';

import 'package:dartboardhc/rest/rest_repsonse.dart';
import 'package:dartboardhc/repository/oh_sitemap_repository.dart';
import 'package:dartboardhc/models/oh_sitemap.dart';

class OhSitemapBloc {
  OhSitemapRepository _ohSitemapRepository;
  StreamController _ohSitemapListController;

  StreamSink<RestResponse<Sitemaps>> get ohSitemapListSink =>
      _ohSitemapListController.sink;

  Stream<RestResponse<Sitemaps>> get ohSitemapListStream =>
      _ohSitemapListController.stream;

  OhSitemapBloc() {
    _ohSitemapListController = StreamController<RestResponse<Sitemaps>>();
    _ohSitemapRepository = OhSitemapRepository();
    fetchSitemaps();
  }

  fetchSitemaps() async {
    ohSitemapListSink.add(RestResponse.loading('Requesting Sitemaps.'));

    try {
      Sitemaps sitemaps =
				await _ohSitemapRepository.fetchOhSitemapData();
      ohSitemapListSink.add(RestResponse.completed(sitemaps));
    } catch (e) {
      ohSitemapListSink.add(RestResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _ohSitemapListController?.close();
  }
}
