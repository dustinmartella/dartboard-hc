import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:dartboardhc/util/string.dart';
import 'package:dartboardhc/rest/rest_exception.dart';

class RestProvider {
  final String _baseUrl = UtilString.trim("https://openhab.martellaville.net/rest", "/");

  Future<dynamic> get(String url) async {
    var responseJson;

		String endpoint = _baseUrl + "/" + UtilString.trim(url, "/");
		String username = 'martellaville';
		String password = 'foxtrotuniform77';
		String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

    try {
      final response = await http.get(endpoint,
					headers: <String, String>{'authorization': basicAuth});

      responseJson = _response(response);

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());

      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());

      case 500:
      default:
        throw FetchDataException(
					'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
