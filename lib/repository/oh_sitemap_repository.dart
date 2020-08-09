import 'dart:async';

import 'package:dartboardhc/rest/rest_provider.dart';
import 'package:dartboardhc/models/oh_sitemap.dart';

class OhSitemapRepository {
  RestProvider _provider = RestProvider();

  Future<Sitemaps> fetchOhSitemapData() async {
    final response = await _provider.get("sitemaps");

    return Sitemaps.fromJson(response);
  }
}
