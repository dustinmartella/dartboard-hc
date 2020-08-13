import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:dartboardhc/util/string.dart';
import 'package:dartboardhc/rest/rest.dart';

class RestProvider {
  //final String _baseUrl = UtilString.trim("https://openhab.martellaville.net/rest", "/");

  Future<dynamic> get(String url) async {
    var responseJson;

		//String endpoint = _baseUrl + "/" + UtilString.trim(url, "/");
		String endpoint = url;
		String username = 'martellaville';
		String password = 'foxtrotuniform77';
		String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

		Map<String, String> getHeaders = {
			'authorization': basicAuth,
			'Accept': 'application/json',
		};

    try {
      final response = await http.get(endpoint, headers: getHeaders);

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
				print(responseJson);
        return responseJson;

      case 400:
      case 404:
        throw BadRequestException(response.body.toString());

      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());

      case 500:
        throw FetchDataException(
					'Internal server error!'
				);

      default:
        throw FetchDataException(
					'An unexpected error occured with status code: ${response.statusCode}'
				);
    }
  }
}
