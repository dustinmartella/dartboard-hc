import 'dart:async';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/models/sitemap.dart';

class SitemapsRepository {
  RestProvider _provider = RestProvider();

  Future<Sitemaps> fetchSitemapsData() async {
    final response = await _provider.get("https://openhab.martellaville.net/rest/sitemaps");

    return Sitemaps.fromJson(response);
  }
}
