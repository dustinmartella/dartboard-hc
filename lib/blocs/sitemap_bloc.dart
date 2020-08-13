import 'dart:async';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/repository/sitemap_repository.dart';
import 'package:dartboardhc/models/sitemap.dart';

class SitemapBloc {
	String sitemapLink;
  SitemapRepository _sitemapRepository;
  StreamController _sitemapListController;

  StreamSink<RestResponse<Sitemap>> get sitemapListSink =>
      _sitemapListController.sink;

  Stream<RestResponse<Sitemap>> get sitemapListStream =>
      _sitemapListController.stream;

  SitemapBloc(String sitemapLink) {
		this.sitemapLink = sitemapLink;

    _sitemapListController = StreamController<RestResponse<Sitemap>>();
    _sitemapRepository = SitemapRepository();

    fetchSitemap();
  }

  fetchSitemap() async {
    sitemapListSink.add(RestResponse.loading('Requesting Sitemap.'));

    try {
      Sitemap sitemap =
				await _sitemapRepository.fetchSitemapData(this.sitemapLink);
      sitemapListSink.add(RestResponse.completed(sitemap));
    } catch (e) {
      sitemapListSink.add(RestResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _sitemapListController?.close();
  }
}
