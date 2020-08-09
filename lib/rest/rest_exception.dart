class RestException implements Exception {
  final _message;
  final _prefix;

  RestException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends RestException {
  FetchDataException([String message])
		: super(message, "Error During Communication: ");
}

class BadRequestException extends RestException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends RestException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends RestException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
