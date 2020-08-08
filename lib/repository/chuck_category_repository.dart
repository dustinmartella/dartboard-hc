import 'dart:async';

import 'package:dartboardhc/networking/ApiProvider.dart';
import 'package:dartboardhc/models/chuck_categories.dart';

class ChuckCategoryRepository {
  ApiProvider _provider = ApiProvider();

  Future<chuckCategories> fetchChuckCategoryData() async {
    final response = await _provider.get("jokes/categories");
    return chuckCategories.fromJson(response);
  }
}
