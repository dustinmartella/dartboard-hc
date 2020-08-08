import 'dart:async';

import 'package:dartboardhc/networking/ApiProvider.dart';
import 'package:dartboardhc/models/chuck_response.dart';

class ChuckRepository {
  ApiProvider _provider = ApiProvider();

  Future<chuckResponse> fetchChuckJoke(String category) async {
    final response = await _provider.get("jokes/random?category=" + category);
    return chuckResponse.fromJson(response);
  }
}
