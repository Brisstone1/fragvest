import 'package:fragvest_mobile/constants/service_const.dart';
import 'package:fragvest_mobile/model/utility_model.dart/failure.dart';

class ServerException implements Exception {
  final String errorMessage;
  ServerException({this.errorMessage = SERVER_ERROR_MESSAGE});
  ServerFailure toFailure() => ServerFailure(error: errorMessage);
}

class InputException implements Exception {
  final String errorMessage;
  InputException({this.errorMessage});
  InputFailure toFailure() => InputFailure(errorMessage: errorMessage);
}

class UnauthorisedException implements Exception {
  final String errorMessage;
  UnauthorisedException({this.errorMessage = ''});
  BadAuthFailure toFailure() => BadAuthFailure(errorMessage: errorMessage);
}

class NetworkException implements Exception {}

class UnknownException implements Exception {}
