import 'dart:async';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/models/sitemap.dart';

class SitemapRepository {
  RestProvider _provider = RestProvider();

  Future<Sitemap> fetchSitemapData(String link) async {
    final response = await _provider.get(link);

    return Sitemap.fromJson(response);
  }
}
