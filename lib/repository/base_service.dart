import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/service_const.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/model/api_response.dart';
import 'package:fragvest_mobile/model/utility_model.dart/failure.dart';
import 'package:fragvest_mobile/utilities/logger_util.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'local_storage.dart';
import 'repo_Validatary.dart';

/// [BaseDatasource]
///
/// Mixin interface to send Http requests and process the response
/// to [ApiResponse] of type [<Map<String, dynamic>>]
///
/// Utilize the transform and transformToStatusOnly functions extended on
/// [ApiResponse<Map<String, dynamic>>] to convert ApiResponses from your
/// datasources, to values/models you wish to use.
///
/// Returns error as [NetworkFailure] if request cannot connect.
///
/// Returns error as [ServerFailure] if status code **500** is returned,
/// or if body returned cannot be decoded (body is not json).
///
/// Return error as [InputFailure] if server returns error based on
/// conditions set in private function `_checkForError`
///
/// Original written by Flutterian MajorE
/// Github: Meghatronics Twitter: MajorE_1
// AuthTokenModel _token = AuthTokenModel.empty;

// set dbToken(AuthTokenModel token) {
//   _token = token;
// }

class BaseDatasource {
  // final String BASE_URL = auth/register';
  // Uri _url(String endpoint) => Uri.https(BASE_URL, '/api/v1/$endpoint');
  Uri _url(String endpoint) => Uri.parse('$BASE_URL/$endpoint');

  Uri _urlWithQueryParams(String endpoint, Map<String, dynamic> queryParams) =>
      // Uri.https(BASE_URL, '/api/v1/$endpoint', queryParams);
      Uri.parse('$BASE_URL/$endpoint');

  // String get userToken => _token.accessToken;
  Map<String, String> get jsonHeadersWithoutToken => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

  Map<String, String> get jsonHeaders => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $TOKEN',
        'Authorization': 'Bearer ${getIt.get<LocalStorage>().getToken()}',
        // 'X-Access-Token': '${getIt.get<StorageService>().getToken()}',
      };

  Future<ApiResponse<Map<String, dynamic>>> _processRequest(
    Future<http.Response> request,
  ) async {
    try {
      final response = await request.timeout(DB_TIMEOUT,
          onTimeout: () => throw TimeoutException(NETWORK_ERROR_MESSAGE));
      debugPrint('RESPONSE STATUS ---- ${response.statusCode}');
      debugPrint('RESPONSE BODY ---- ${response.body}');
      final data = jsonDecode(response.body);

      final error = _checkForError(response.statusCode, data);
      return ApiResponse(
        data: data,
        error: error,
      );
    } on FormatException {
      return ApiResponse(error: ServerFailure(error: SERVER_ERROR_MESSAGE));
    } catch (e) {
      return ApiResponse(error: convertException(e));
    }
  }

  ///Send a http *GET* request to "`$BASE_URL$`[endpoint]"
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendGet(
      {String endpoint,
      bool useToken = true,
      Map<String, dynamic> queryParams}) {
    final url = queryParams != null
        ? _urlWithQueryParams(endpoint, queryParams)
        : _url(endpoint);

    final request = http.get(
      url,
      headers: useToken ? jsonHeaders : jsonHeadersWithoutToken,
    );
    debugPrint('REQUEST -- $url');
    return _processRequest(request);
  }

  ///Send a http *POST* request to "`$BASE_URL$`[endpoint]".
  ///[payload] is encoded and sent as request body.
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendPost(
      {String endpoint,
      Map<String, dynamic> payload,
      bool useToken = true}) async {
    final url = _url(endpoint);
    final body = jsonEncode(payload);
    final request = http.post(
      url,
      body: body,
      headers: useToken ? jsonHeaders : jsonHeadersWithoutToken,
    );
    debugPrint('REQUEST -- $url -- $payload');
    return _processRequest(request);
  }

  Future<ApiResponse<Map<String, dynamic>>> sendTermiiPost({
    String endpoint,
    Map<String, dynamic> payload,
  }) async {
    final body = jsonEncode(payload);
    final request = http.post(
      Uri.parse(endpoint),
      body: body,
      headers: jsonHeadersWithoutToken,
    );
    debugPrint('REQUEST -- $endpoint -- $payload');
    return _processRequest(request);
  }

  Future<ApiResponse<Map<String, dynamic>>> sendListPost(
      {@required String endpoint,
      @required List<Map<String, dynamic>> payload,
      bool useToken = true}) async {
    final url = _url(endpoint);
    final body = jsonEncode(payload);
    final request = http.post(
      url,
      body: body,
      headers: useToken ? jsonHeaders : jsonHeadersWithoutToken,
    );
//  final respBody = await request.then((resp) => print(resp.body));
    debugPrint('REQUEST -- $url -- $payload');
    return _processRequest(request);
  }

  ///Send a http *PATCH* request to "`$BASE_URL$`[endpoint]".
  ///[payload] is encoded and sent as request body.
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendPatch(
      {@required String endpoint,
      @required Map<String, dynamic> payload,
      bool useToken = true}) async {
    final url = _url(endpoint);
    final body = jsonEncode(payload);
    final request = http.patch(
      url,
      body: body,
      headers: useToken ? jsonHeaders : jsonHeadersWithoutToken,
    );
    debugPrint('REQUEST -- $url -- $payload');
    return _processRequest(request);
  }

  ///Send a http *PUT* request to "`$BASE_URL$`[endpoint]".
  ///[payload] is encoded and sent as request body.
  ///
  ///[useToken] determines whether to add Authorisation token
  ///to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendPut(
      {@required String endpoint,
      @required Map<String, dynamic> payload,
      bool useToken = true}) async {
    final url = _url(endpoint);
    final body = jsonEncode(payload);
    final request = http.put(
      url,
      body: body,
      headers: useToken ? jsonHeaders : jsonHeadersWithoutToken,
    );
    debugPrint('REQUEST -- $url -- $payload');
    return _processRequest(request);
  }

  ///Send a http *MULTIPART* request to "`$BASE_URL$`[endpoint]"
  ///with files as the values in [files] as their keys
  ///
  ///Map key and value in [fields] are added to the request if !null or empty
  ///Authorisation token is added to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendMultipartImage({
    String method = 'POST',
    @required String endpoint,
    @required Map<String, File> files,
    Map<String, dynamic> fields,
    bool useToken = true,
  }) async {
    // Make request variable with url
    final request = http.MultipartRequest(method, _url(endpoint));
// If [useToken] Add authorisation header to request variable
    print(getIt.get<LocalStorage>().getToken());
    if (useToken)
      request.headers.putIfAbsent(
        'x-access-token',
        () => getIt.get<LocalStorage>().getToken() ?? '',
      );
// Add the files to request variable as their key
    files?.forEach((key, value) async {
      request.files.add(await http.MultipartFile.fromPath(
        '$key',
        value.path,
        contentType: MediaType(
          'image',
          'jpeg',
        ),
      ));
    });
// If other fields exist, add them to the request
    if (fields != null && fields.isNotEmpty) {
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
    }
// Send the request and receive a stream as response
//     final responseStream = await (request.send());
// Convert the stream returned to regular response
    final multipartRequest = http.Response.fromStream(await request.send());
    debugPrint('REQUEST -- $endpoint -- MULTIPART FILE (${files?.length})');
    return _processRequest(multipartRequest);
  }

  ///Send a http *MULTIPART* request to "`$BASE_URL$`[endpoint]"
  ///with files as the values in [files] as their keys
  ///
  ///Map key and value in [fields] are added to the request if !null or empty
  ///Authorisation token is added to request headers.
  Future<ApiResponse<Map<String, dynamic>>> sendMultipartAudio({
    String method = 'POST',
    @required String endpoint,
    @required Map<String, File> files,
    Map<String, dynamic> fields,
    bool useToken = true,
  }) async {
    // Make request variable with url
    final request = http.MultipartRequest(method, _url(endpoint));
// If [useToken] Add authorisation header to request variable
    if (useToken)
      request.headers.putIfAbsent(
        'x-access-token',
        () => jsonHeaders['Authorization'] ?? '',
      );
// Add the files to request variable as their key
    files?.forEach((key, value) async {
      request.files.add(await http.MultipartFile.fromPath(
        '$key',
        value.path,
        contentType: MediaType('audio', 'mpeg'),
      ));
    });
// If other fields exist, add them to the request
    if (fields != null && fields.isNotEmpty) {
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
    }
// Send the request and receive a stream as response
//     final responseStream = await (request.send());
// Convert the stream returned to regular response
    final multipartRequest = http.Response.fromStream(await request.send());
    debugPrint('REQUEST -- $endpoint -- MULTIPART FILE (${files?.length})');
    return _processRequest(multipartRequest);
  }

  Failure _checkForError(int statusCode, data) {
    String returnedMessage;
    // returnedMessage = '';
    // if (statusCode - 200 <= 99) return NullFailure();
    if (data != null) {
      //Check if request was successful
      bool success = data['success'] ?? false;
      //If successful, return no failure
      // Null failure should be returned if success
      if (success) return NullFailure();
      final errors = data['message'] ?? data['msg'] ?? data['error'];
      //Check list of errors
      if (errors is String) {
        returnedMessage = errors;
      } else if (errors is Map) {
        //If no error field - use messsage for failure
        if (errors.isEmpty) {
          returnedMessage = data['message'];
        }
        //If there are error fields - use errors for failure
        else {
          // returnedMessage = errors;
          errors.forEach((key, value) {
            if (value is List) {
              returnedMessage = value.first;
            } else {
              returnedMessage = '$returnedMessage\n$value';
            }
          });
        }
      } else if (errors is List) {
        if (errors.isEmpty) {
          returnedMessage = null;
        } else {
          errors.forEach((value) {
            if (value is String) {
              returnedMessage = '$value';
            }
          });
        }
      }
    }

    returnedMessage ??= SERVER_ERROR_MESSAGE;
    print('-----$returnedMessage-----');

    if (statusCode == 401) {
      return BadAuthFailure(errorMessage: returnedMessage);
    } else if (statusCode == 403) {
      return BadAuthFailure(errorMessage: returnedMessage);
    } else if (statusCode == 404) {
      return NotFoundFailure(errorMessage: returnedMessage);
    } else if (statusCode == 500) {
      return ServerFailure(error: returnedMessage);
    } else if (statusCode == 502) {
      return ServerFailure(error: returnedMessage);
    } else if (statusCode == 503) {
      return ServerFailure(error: returnedMessage);
    } else if (statusCode == 504) {
      return ServerFailure(error: returnedMessage);
    } else {
      return UnknownFailure(message: returnedMessage);
    }
    // switch (statusCode) {
    //   // status code can be 200 and error will still occured
    //   case 200:
    //     return ServerFailure(error: returnedMessage);
    //   case 403:
    //     return BadAuthFailure(errorMessage: returnedMessage);
    //   case 500:
    //     return ServerFailure(error: returnedMessage);
    //   default:
    //     return InputFailure(errorMessage: returnedMessage);
    // }
  }

  Future<LogValidator> dioPostFormData(
      {@required String apiUrl, @required Map<String, dynamic> payload}) async {
    Response response;
    try {
      final url = '$BASE_URL/$apiUrl';
      print('The url $url');
      var dio = Dio();
      var formData = FormData.fromMap(payload);

      response = await dio.put(
        url,
        options: Options(headers: jsonHeaders),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );

      logger.d('The response $response');

      if (response.statusCode == 200) {
        return LogSucess(response.data['message']);
      } else {
        return LogFailure(response.data["message"] ?? "Try again");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return LogFailure('Check your connection');
      } else if (e.error is SocketException) {
        return LogFailure('No internet connection');
      } else if (e.error is HttpException) {
        return LogFailure('No internet connection');
      } else if (e.type == DioErrorType.other) {
        return LogFailure('Oops! Something went wrong');
      } else if (e.type == DioErrorType.receiveTimeout) {
        return LogFailure('Oops! Time out, try again later');
      } else if (e.type == DioErrorType.sendTimeout) {
        return LogFailure('Oops! Time out try again later');
      } else if (e.type == DioErrorType.receiveTimeout) {
        return LogFailure('Oops! Time out, try again later');
      } else if (e.type == DioErrorType.response) {
        return LogFailure('Could not upload document, try again');
      } else {
        rethrow;
      }
    }
  }
}
