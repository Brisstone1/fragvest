import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fragvest_mobile/constants/service_const.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/local_storage.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/utilities/logger_util.dart';
import 'package:fragvest_mobile/utilities/service_header.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../model/paystack_access_token.dart';
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class PostServices {
  static Future<RepoValidator> signupUser(BuildContext context,
      {String email,
      String password,
      String comfirmPassword,
      String phone}) async {
    try {
      final uri = BASEURL + 'register';

      final response = await http.post(
        Uri.parse(uri),
        headers: <String, String>{
          'content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
          'confirmPassword': comfirmPassword,
          'phone': phone
        }),
      );

      print(response.body);
      print("=================response");

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        Provider.of<ServiceProvider>(context, listen: false)
            .setSignupEmail(email);
        return RepoSucess();
      } else {
        return RepoFailure(result["message"][0] ?? "Try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> loginUser(
      {BuildContext context, String email, String password}) async {
    try {
      final uri = BASEURL + 'login';

      final response = await http.post(
        Uri.parse(uri),
        headers: <String, String>{
          'content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, dynamic>{'email': email, 'password': password}),
      );

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        // logger.d(result['data']['complete_registration']);
        // ServiceProvider serviceProvider = context.watch<ServiceProvider>();
        final serviceProvider =
            Provider.of<ServiceProvider>(context, listen: false);
        // logger.d(result['data']['profile_img']);
        serviceProvider.setUserDetail(
            first: result['data']['first_name'],
            last: result['data']['last_name'],
            balance: result['wallet_balance'],
            mail: result['data']['email'],
            phone: result['data']['phone']);
        serviceProvider.setuserImage(
          image: result['data']['profile_img'],
        );

        String firstName = result['data']['first_name'] ?? 'User';
        String lastName = result['data']['last_name'] ?? 'User';
        logger.d(firstName);
        logger.d(lastName);

        String _token = await result['token'];
        await getIt.get<LocalStorage>().saveToken(_token);
        await getIt.get<LocalStorage>().saveFirstName(firstName);
        await getIt.get<LocalStorage>().saveLastName(lastName);
        await getIt.get<LocalStorage>().saveEmail(result['data']['email']);
        await getIt.get<LocalStorage>().savePhone(result['data']['phone']);

        Provider.of<UserToken>(context, listen: false).userToken = _token;

        if (result['data']['verification_status'] == 'unverified') {
          return LogSucess(result['data']['verification_status']);
        } else {
          if (result['data']['is_deleted'] == 1) {
            return LogSucess("deleted");
          } else {
            return LogSucess("${result['data']['complete_registration']}");
          }
        }

        // ;
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } on TimeoutException {
      return LogFailure("Time Out");
    } on HttpException {
      return LogFailure("Time Out: Try again");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> completeRegistration(
      {BuildContext context,
      String employmentStatus,
      String annualIncome,
      String investmentFamiliarity,
      String sourceOfInvestmentAdvice,
      String yearlyInvestment,
      String durationOfInvestment,
      String gender,
      String dateOfBirth,
      int countryId,
      String firstName,
      String lastName,
      String posterCode,
      String address}) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL +
          'complete-registration?employment_status=$employmentStatus&annual_income=$annualIncome&investment_familiarity=$investmentFamiliarity&source_of_investment_advice=$sourceOfInvestmentAdvice&yearly_investment=$yearlyInvestment&duration_of_investment=$durationOfInvestment&gender=$gender&date_of_birth=$dateOfBirth&country_id=$countryId&first_name=$firstName&last_name=$lastName&postal_code=$posterCode&address=$address';

      final response =
          await http.post(Uri.parse(uri), headers: setHeaders(_token)
              // body: ,5
              );

      final result = await jsonDecode(response.body);
      logger.d(result);
      // logger.d(response.statusCode);

      if (response.statusCode == 200) {
        return LogSucess(result['message'] ?? 'Sign up completed');
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<RepoValidator> forgortPassword(
      String token, String email) async {
    try {
      final uri = BASEURL + 'forgot-password';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(token),
        body: jsonEncode(<String, dynamic>{'email': email}),
      );

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return RepoSucess();
      } else {
        return RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<RepoValidator> veryEmailToken(
      String token, String email, String emailToken) async {
    try {
      final uri = BASEURL + 'verify-token';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(token),
        body:
            jsonEncode(<String, dynamic>{'email': email, 'token': emailToken}),
      );

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return RepoSucess();
      } else {
        return RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<RepoValidator> resetPassword(String token, String newPassword,
      String confirmNewPassword, String email, String emailToken) async {
    try {
      final uri = BASEURL + 'change-password';

      final response = await http.post(Uri.parse(uri),
          headers: setHeaders(token),
          body: jsonEncode(<String, dynamic>{
            'newPassword': newPassword,
            'confirmNewPassword': confirmNewPassword,
            'email': email,
            'token': emailToken
          }));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return RepoSucess();
      } else {
        return RepoFailure(result["message"][0] ?? "Try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<RepoValidator> uploadId(
      {String token,
      String type,
      String idNumber,
      // String frontImageName,
      XFile frontImagePath,
      // String backImageName,
      XFile backImagepath}) async {
    Response response;
    try {
      final url = BASEURL + 'upload-id';
      // 'https://dev.fragvest.com/api/v1/upload-id';

      var dio = Dio();
      String frontFileName = frontImagePath.path.split('/').last;
      String backFileName = backImagepath.path.split('/').last;
      var formData = FormData.fromMap({
        'type': type,
        'id_number': idNumber,
        'image_frontview': await MultipartFile.fromFile(frontImagePath.path,
            filename: frontFileName, contentType: MediaType("image", "jpeg")),
        'image_backview': await MultipartFile.fromFile(backImagepath.path,
            filename: backFileName, contentType: MediaType("image", "jpeg"))
      });
      response = await dio.post(
        url,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );

      logger.d('The response ${response.data}');

      if (response.statusCode == 200) {
        return RepoSucess();
      } else {
        print('Get message ${response.data["message"]}');
        return RepoFailure(response.data["message"] ?? "Try again");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return RepoFailure('check your connection');
        // return RepoFailure('No internet Connectio');
      } else if (e.error is SocketException) {
        print('no internet connection');
        return RepoFailure('No internet connection');
      } else if (e.type == DioErrorType.other) {
        print('Something went wrong');
        return RepoFailure('Oops! Something went wrong');
      } else if (e.type == DioErrorType.receiveTimeout) {
        print('Time out');
        return RepoFailure('Time out');
      } else {
        rethrow;
      }
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      // if (e.response != null) {
      //   print(e.response.data);
      //   print(e.response.headers);
      //   print(e.response.requestOptions);
      // } else {
      //   // Something happened in setting up or sending the request that triggered an Error
      //   print(e.requestOptions);
      //   print(e.message);
      // }
    }
    // try {
    //   final url = 'https://dev.fragvest.com/api/v1/upload-id';

    //   var dio = Dio();
    //   String frontFileName = frontImagePath.path.split('/').last;
    //   String backFileName = backImagepath.path.split('/').last;

    //   // final response = await http.post(Uri.parse(url), headers: setHeaders(token));
    //   var formData = FormData.fromMap({
    //     'type': type,
    //     'id_number': idNumber,
    //     'image_frontview': await MultipartFile.fromFile(frontImagePath.path,
    //         filename: frontFileName, contentType: MediaType("image", "jpeg")),
    //     'image_backview': await MultipartFile.fromFile(backImagepath.path,
    //         filename: backFileName, contentType: MediaType("image", "jpeg"))
    //   });
    //   var response = await dio.post(
    //     url,
    //     options: Options(headers: {
    //       'Content-Type': 'multipart/form-data',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token'
    //     }),
    //     data: formData,
    //     onSendProgress: (int sent, int total) {
    //       print('$sent $total');
    //     },
    //   );

    //   // final result = await jsonDecode(response.data);
    //   // logger.d(result);
    //   logger.d('The response ${response.data}');

    //   if (response.statusCode == 200) {
    //     return RepoSucess();
    //   } else {
    //     return RepoFailure("Try again");
    //   }
    // } on SocketException {
    //   return RepoFailure("No internet connection");
    // } catch (e) {
    //   rethrow;
    // }
  }

  static Future<LogValidator> addBank(String token, String bankId,
      String accountName, String accountNumber) async {
    try {
      print('AWARE---');
      final uri = BASEURL +
          'add-bank?bank_id=$bankId&account_name=$accountName&account_number=$accountNumber';

      final response =
          await http.post(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? 'Bank added successfully');
      } else {
        return LogFailure(result["message"] ?? 'Try again');
      }
    } on SocketException {
      return LogFailure('NO internet connection');
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> withdrawFund(
      BuildContext context, String amount, String pin, int bankId) async {
    try {
      String token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'withdraw';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(token),
        body: jsonEncode(
            <String, dynamic>{'amount': amount, 'pin': pin, 'bank_id': bankId}),
      );

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? 'Withdrawal successfully placed');
      } else {
        return LogFailure(result["message"] ?? 'Try again');
      }
    } on SocketException {
      return LogFailure('N0 internet connection');
    } catch (e) {
      rethrow;
    }
  }

  static Future<RepoValidator> logoutUser(String token) async {
    try {
      final uri = BASEURL + 'logout';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(token),
      );

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return RepoSucess();
      } else {
        return RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> securityPin(String token, String pin) async {
    try {
      final uri = BASEURL + 'create-pin?pin=$pin';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(token),
      );

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return LogSucess(
            result["message"] ?? "Security pin added successfully");
      } else {
        return LogFailure(result["message"][0] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  // static Future<LogValidator> uploadSaleProperty(String token, String type,
  //     String negotiable, String address, int orice, double, lognCodinate, double latCodinate, String deatil, String description,  ) async {
  //   try {
  //     final uri = BASEURL +'upload_property';

  //     final response =
  //         await http.post(Uri.parse(uri), headers: setHeaders(token),  body: jsonEncode(<String, dynamic>{
  //           'newPassword': newPassword,
  //           'confirmNewPassword': confirmNewPassword,
  //           'email': email,
  //           'token': emailToken
  //         }));

  //     final result = await jsonDecode(response.body);
  //     logger.d(result);

  //     if (response.statusCode == 200) {
  //       return LogSucess(result["message"] ?? 'Bank added successfully');
  //     } else {
  //       return LogFailure(result["message"] ?? 'Try again');
  //     }
  //   } on SocketException {
  //     return LogFailure('NO internet connection');
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  static Future<RepoValidator> uploadProperty(
      {String token,
      String name,
      String type,
      String propertyDetail,
      String location,
      double longCoordinate,
      double latCoordinate,
      List<XFile> propertyImages,
      String owner,
      String price,
      String typeDetail}) async {
    Response response;
    try {
      final url = BASEURL + 'upload_property_user';
      print('The url $url');

      // 'https://dev.fragvest.com/api/v1/upload_property_user';

      var dio = Dio();

      var files = [];

      for (var file in propertyImages) {
        print(file);
        files.add(await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last,
            contentType: MediaType("image", "jpeg")));
      }
      // print('Object of $files');

      print(longCoordinate);
      print(latCoordinate);

      var formData = FormData.fromMap({
        'property_name': name,
        'type': type,
        'property_details': propertyDetail,
        'property_location': location,
        'long_coordinate': longCoordinate,
        'lat_coordinate': latCoordinate,
        'property_image': files,
        'outright_owner': owner,
        'selling_price': price,
        'type_detail': typeDetail
      });

      response = await dio.post(
        url,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );

      logger.d('The response ${response.data}');

      if (response.statusCode == 200) {
        return RepoSucess();
      } else {
        print('Get message ${response.data["message"]}');
        return RepoFailure(response.data["message"] ?? "Try again");
      }
    } on DioError catch (e) {
      print('The error $e');
      if (e.type == DioErrorType.connectTimeout) {
        return RepoFailure('check your connection');
        // return RepoFailure('No internet Connectio');
      } else if (e.error is SocketException) {
        print('no internet connection');
        return RepoFailure('No internet connection');
      } else if (e.type == DioErrorType.other) {
        print('Something went wrong');
        return RepoFailure('Oops! Something went wrong');
      } else if (e.type == DioErrorType.receiveTimeout) {
        print('Time out');
        return RepoFailure('Time out');
      } else {
        rethrow;
      }
    }
  }

  static Future<LogValidator> addNewCard(
      String token, int number, String cvv, String expireDate) async {
    try {
      final uri = BASEURL + 'add-card';
      print('The card number $number');

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(token),
        body: jsonEncode(<String, dynamic>{
          'card_number': number,
          'card_cvv': cvv,
          'card_expiry_date': expireDate
        }),
      );

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return LogSucess(
            result["message"] ?? "Security pin added successfully");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> addWatchlist(
      BuildContext context, String propertyId) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      // logger.d('Get the toke $_token');
      final uri = BASEURL + 'add-to-watchlist';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{'property_id': propertyId}),
      );

      final result = await jsonDecode(response.body);
      // logger.d('The log $result["message"]');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "Watchlist added");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> removeWathlist(
      BuildContext context, String propertyId) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'remove-from-watchlist';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{'property_id': propertyId}),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "Watchlist removed");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  // static Future<LogValidator> comfirmPayment(
  //     BuildContext context, String reference, num amount) async {
  //   try {
  //     String _token = Provider.of<UserToken>(context, listen: false).userToken;

  //     final uri = BASEURL + 'confirm-payment';

  //     final response = await http.post(
  //       Uri.parse(uri),
  //       headers: setHeaders(_token),
  //       body: jsonEncode(
  //           <String, dynamic>{'reference': reference, 'amount': amount}),
  //     );

  //     final result = await jsonDecode(response.body);
  //     // logger.d('The log $result');

  //     if (response.statusCode == 200) {
  //       return LogSucess(result["message"] ?? "Payment comfirmed");
  //     } else {
  //       return LogFailure(result["message"] ?? "Try again");
  //     }
  //   } on SocketException {
  //     return LogFailure("No internet connection");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  static Future<LogValidator> creatReview(BuildContext context,
      String propertyId, String message, String rate) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'post-review';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{
          'property_id': propertyId,
          'message': message,
          'stars': rate
        }),
      );

      final result = await jsonDecode(response.body);
      // logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "Review posted");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> rentProperty(
      BuildContext context, int propertyId, String duration) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'get-property';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(
            <String, dynamic>{'property_id': propertyId, 'duration': duration}),
      );

      final result = await jsonDecode(response.body);
      // logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "property rented");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> investProperty(
      BuildContext context, int propertyId, String amount) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'get-property';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(
            <String, dynamic>{'property_id': propertyId, 'amount': amount}),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "property rented");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> buyProperty(
      BuildContext context, int propertyId) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'get-property';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{'property_id': propertyId}),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "property rented");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> updateProfileImage({
    BuildContext context,
    XFile imagePath,
  }) async {
    Response response;
    try {
      // print(imagePath.path);
      String token = Provider.of<UserToken>(context, listen: false).userToken;
      final _serviceProvider =
          Provider.of<ServiceProvider>(context, listen: false);
      final url = BASEURL + 'edit-profile-img';

      var dio = Dio();
      String fineName = imagePath.path.split('/').last;
      var formData = FormData.fromMap({
        'profile_img': await MultipartFile.fromFile(imagePath.path,
            filename: fineName, contentType: MediaType("image", "jpeg")),
      });
      response = await dio.post(
        url,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }),
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );

      if (response.statusCode == 200) {
        _serviceProvider.setuserImage(image: response.data["data"]);
        logger.d('The updated image ${response.data["data"]}');
        return LogSucess(response.data["message"]);
      } else {
        return LogFailure(response.data["message"] ?? "Try again");
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return LogFailure('check your connection');
        // return LogFailure('No internet Connectio');
      } else if (e.error is SocketException) {
        print('no internet connection');
        return LogFailure('No internet connection');
      } else if (e.type == DioErrorType.other) {
        print('Something went wrong');
        return LogFailure('Oops! Something went wrong');
      } else if (e.type == DioErrorType.receiveTimeout) {
        print('Time out');
        return LogFailure('Time out');
      } else {
        rethrow;
      }
    }
  }

  static Future<LogValidator> scheduleTour(
      {BuildContext context,
      int propertyId,
      String dateTime,
      String email,
      String phone}) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'schedule-tour';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{
          'property_id': propertyId,
          'scheduled_date': dateTime,
          'email': email,
          'phone': phone
        }),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "property rented");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> changePassword(
      BuildContext context, oldPwd, String newPwd, String comfrimPwd) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'change-user-password';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{
          'old_password': oldPwd,
          'new_password': newPwd,
          'confirm_new_password': comfrimPwd,
        }),
      );

      final result = await jsonDecode(response.body);
      // logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "Password changed sucessfully");
      } else {
        return LogFailure(result["message"][0] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<RepoValidator> createTicket(
      BuildContext context, String subject, String description) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'create-ticket';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(
            <String, dynamic>{'subject': subject, 'description': description}),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        return RepoSucess();
      } else {
        return RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<RepoValidator> replyTicket(
      BuildContext context, String ticketId, String description) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'reply-ticket';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{
          'ticket_id': ticketId,
          'description': description
        }),
      );

      final result = await jsonDecode(response.body);
      // logger.d('The log $result');

      if (response.statusCode == 200) {
        return RepoSucess();
      } else {
        return RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> resetProfileImage(BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'reset-profile-image';

      final response =
          await http.post(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"]);
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> paystackAccessCode(
      BuildContext context, String amount) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;

      final uri = BASEURL + 'reply-ticket';

      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{'amount': amount}),
      );

      final result = await jsonDecode(response.body);
      // logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result['access_code']);
      } else {
        return LogFailure(result["message"][0] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> deleteBankAccount(
      BuildContext context, int accountId) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'delete-bank-account';
      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{'account_id': accountId}),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "Bank Account Deleted");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<LogValidator> deleteBankCard(
      BuildContext context, int accountId) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'delete-bank-card?card_id=$accountId';
      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        return LogSucess(result["message"] ?? "Bank Account Deleted");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<RepoValidator> bankPayment(
      BuildContext context, String amount) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      ServiceProvider serviceProvider =
          Provider.of<ServiceProvider>(context, listen: false);
      final uri = BASEURL + 'get-access-code';
      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        body: jsonEncode(<String, dynamic>{'amount': amount}),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        final data = PaystackAccessToken.fromJson(result);
        serviceProvider.setAuthorizationUrl(data.accessCode.authorizationUrl);
        serviceProvider.setAccessCode(data.accessCode.accessCode);
        serviceProvider.setReference(data.accessCode.reference);
        return RepoSucess();
      } else {
        return RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }


  static Future<LogValidator> resendVerificationMail(
      BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      print(_token);
      final uri = Admin_BASE_URL + 'resend-verification-link';
      final response = await http.post(
        Uri.parse(uri),
        headers: setHeaders(_token),
        // body: jsonEncode(<String, dynamic>{'account_id': accountId}),
      );

      final result = await jsonDecode(response.body);
      logger.d('The log $result');

      if (response.statusCode == 200) {
        // return RepoSucess();
        print("entereeeee");
        // return LogSucess(result['message']['Link Resent']);
        return LogSucess(result["message"] ?? "Link Resent");
      } else {
        return LogFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      return LogFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }


}


