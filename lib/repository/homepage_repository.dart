import 'dart:async';

import 'package:dartboardhc/rest/rest.dart';
import 'package:dartboardhc/models/sitemap.dart';

class HomepageRepository {
  RestProvider _provider = RestProvider();

  Future<Homepage> fetchHomepageData(String link) async {
    final response = await _provider.get(link);

    return Homepage.fromJson(response);
  }
}
