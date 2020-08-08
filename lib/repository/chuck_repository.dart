import 'dart:async';

import 'package:homefly/networking/ApiProvider.dart';
import 'package:homefly/models/chuck_response.dart';

class ChuckRepository {
  ApiProvider _provider = ApiProvider();

  Future<chuckResponse> fetchChuckJoke(String category) async {
    final response = await _provider.get("jokes/random?category=" + category);
    return chuckResponse.fromJson(response);
  }
}
