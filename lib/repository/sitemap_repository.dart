import 'dart:async';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/models/sitemap.dart';

class SitemapRepository {
  RestProvider _provider = RestProvider();

  Future<Sitemap> fetchSitemapData(String sitemapName) async {
    final response = await _provider.get("sitemaps/$sitemapName");

    return Sitemap.fromJson(response);
  }
}
