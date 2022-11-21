import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fragvest_mobile/constants/service_const.dart';
import 'package:fragvest_mobile/model/all_properties_model.dart';
import 'package:fragvest_mobile/model/chat_model.dart';
import 'package:fragvest_mobile/model/dashboard_model.dart';
import 'package:fragvest_mobile/model/fee_model.dart';
import 'package:fragvest_mobile/model/get_all_tickets_model.dart';
import 'package:fragvest_mobile/model/get_blog_post_model.dart';
import 'package:fragvest_mobile/model/get_card_model.dart';
import 'package:fragvest_mobile/model/get_country_model.dart';
import 'package:fragvest_mobile/model/notification_model.dart';
import 'package:fragvest_mobile/model/paystack_bank_list.dart';
import 'package:fragvest_mobile/model/portfolio_model.dart';
import 'package:fragvest_mobile/model/property_by_type_model.dart';
import 'package:fragvest_mobile/model/transaction_history_model.dart';
import 'package:fragvest_mobile/model/user_bank_account_model.dart';
import 'package:fragvest_mobile/model/user_model.dart';
import 'package:fragvest_mobile/model/wallet_balance_model.dart';
import 'package:fragvest_mobile/model/watch_list_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/support/create_ticket.dart';
import 'package:fragvest_mobile/utilities/logger_util.dart';
import 'package:fragvest_mobile/utilities/service_header.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/wallet_transaction_history_model.dart';

class GetServices {
  static Future<Object> getCountries(BuildContext context) async {
    try {
      String token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get-countries';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return GetCountryModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getStates(String token, int countryId) async {
    try {
      final uri = BASEURL + "get-states?country_id=${countryId}";

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      logger.d(result);
//
      if (response.statusCode == 200) {
        return GetStateModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getCities(String token, int stateId) async {
    try {
      final uri = BASEURL + "get-cities?state_id=${stateId}";

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return GetCityModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future getDashbord(BuildContext context) async {
    String _token = Provider.of<UserToken>(context, listen: false).userToken;
    try {
      final uri = BASEURL + 'dashboard';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return DashboardModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getPropertyByFilter(
    BuildContext context,
    String type,
  ) async {
    try {
      String token = Provider.of<UserToken>(context, listen: false).userToken;
      ServiceProvider serviceProvider =
          Provider.of<ServiceProvider>(context, listen: false);
      // uri = BASEURL +
      //     'get_properties?type=$type&range=$priceRange&property_type=$propertType&rooms=$rooms&bedroom=$bedroom';
      var uri;
      if (serviceProvider.propertyType == null &&
          serviceProvider.priceRange != null &&
          serviceProvider.rooms != null &&
          serviceProvider.bedroom != null) {
        print('step 1');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.priceRange}&rooms=${serviceProvider.rooms}&bedroom=${serviceProvider.bedroom}';
      } else if (serviceProvider.priceRange == null &&
          serviceProvider.propertyType != null &&
          serviceProvider.rooms != null &&
          serviceProvider.bedroom != null) {
        print('step 2');
        uri = BASEURL +
            'get_properties?type=$type&property_type=${serviceProvider.propertyType}&rooms=${serviceProvider.rooms}&bedroom=${serviceProvider.bedroom}';
      } else if (serviceProvider.rooms == null &&
          serviceProvider.propertyType != null &&
          serviceProvider.priceRange != null &&
          serviceProvider.bedroom != null) {
        print('step 3');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.priceRange}&property_type=${serviceProvider.propertyType}&bedroom=${serviceProvider.bedroom}';
      } else if (serviceProvider.bedroom == null &&
          serviceProvider.propertyType != null &&
          serviceProvider.priceRange != null &&
          serviceProvider.rooms != null) {
        print('step 4');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.priceRange}&property_type=${serviceProvider.propertyType}&rooms=${serviceProvider.rooms}';
      } else if (serviceProvider.propertyType != null &&
          serviceProvider.priceRange == null &&
          serviceProvider.rooms == null &&
          serviceProvider.bedroom == null) {
        print('step 5');
        uri = BASEURL +
            'get_properties?type=$type&property_type=${serviceProvider.propertyType}';
      } else if (serviceProvider.priceRange != null &&
          serviceProvider.propertyType == null &&
          serviceProvider.rooms == null &&
          serviceProvider.bedroom == null) {
        print('step 6');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.priceRange}';
      } else if (serviceProvider.rooms != null &&
          serviceProvider.propertyType == null &&
          serviceProvider.priceRange == null &&
          serviceProvider.bedroom == null) {
        print('step 7');
        uri = BASEURL +
            'get_properties?type=$type&rooms=${serviceProvider.rooms}';
      } else if (serviceProvider.bedroom != null &&
          serviceProvider.propertyType == null &&
          serviceProvider.priceRange == null &&
          serviceProvider.rooms == null) {
        print('step 8');
        uri = BASEURL +
            'get_properties?type=$type&bedroom=${serviceProvider.bedroom}';
      } else if (serviceProvider.propertyType != null &&
          serviceProvider.priceRange != null &&
          serviceProvider.bedroom == null &&
          serviceProvider.rooms == null) {
        print('step 9');
        uri = BASEURL +
            'get_properties?type=$type&property_type=${serviceProvider.propertyType}&range=${serviceProvider.priceRange}';
      } else if (serviceProvider.priceRange != null &&
          serviceProvider.rooms != null &&
          serviceProvider.propertyType == null &&
          serviceProvider.bedroom == null) {
        print('step 10');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.priceRange}&rooms=${serviceProvider.rooms}';
      } else if (serviceProvider.priceRange != null &&
          serviceProvider.bedroom != null &&
          serviceProvider.propertyType == null &&
          serviceProvider.rooms == null) {
        print('step 11');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.priceRange}&bedroom=${serviceProvider.bedroom}';
      } else if (serviceProvider.propertyType != null &&
          serviceProvider.rooms != null &&
          serviceProvider.priceRange == null &&
          serviceProvider.bedroom == null) {
        print('step 12');
        uri = BASEURL +
            'get_properties?type=$type&property_type=${serviceProvider.propertyType}&rooms=${serviceProvider.rooms}';
      } else if (serviceProvider.propertyType != null &&
          serviceProvider.bedroom != null &&
          serviceProvider.priceRange == null &&
          serviceProvider.rooms == null) {
        print('step 13');
        uri = BASEURL +
            'get_properties?type=$type&property_type=${serviceProvider.propertyType}&bedroom=${serviceProvider.bedroom}';
      } else if (serviceProvider.rooms != null &&
          serviceProvider.bedroom != null &&
          serviceProvider.priceRange == null &&
          serviceProvider.propertyType == null) {
        print('step 14');
        uri = BASEURL +
            'get_properties?type=$type&rooms=${serviceProvider.rooms}&bedroom=${serviceProvider.bedroom}';
      } else {
        print('step last');
        // uri = BASEURL +
        //     'get_properties?type=$type&range=${serviceProvider.priceRange}&property_type=${serviceProvider.propertyType}&rooms=${serviceProvider.rooms}&bedroom=${serviceProvider.bedroom}';
        uri = BASEURL + 'get_properties?type=$type';
      }

      // 'get_properties?type=sale&range=1000-100000000&property_type=Apartment';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return AllPropertiesModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getPropertyBySingleFilter(
    BuildContext context,
    String type,
  ) async {
    try {
      String token = Provider.of<UserToken>(context, listen: false).userToken;
      ServiceProvider serviceProvider =
          Provider.of<ServiceProvider>(context, listen: false);
      var uri;
      if (serviceProvider.priceRange == null &&
          serviceProvider.rooms != null &&
          serviceProvider.bedroom != null) {
        print('step 1');
        uri = BASEURL +
            'get_properties?type=$type&rooms=${serviceProvider.rooms}&bedroom=${serviceProvider.bedroom}';
      } else if (serviceProvider.rooms == null &&
          serviceProvider.priceRange != null &&
          serviceProvider.bedroom != null) {
        print('step 2');
        uri = BASEURL +
            'get_properties?type=$type&property_type=${serviceProvider.priceRange}&bedroom=${serviceProvider.bedroom}';
      } else if (serviceProvider.bedroom == null &&
          serviceProvider.priceRange != null &&
          serviceProvider.rooms != null) {
        print('step 3');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.priceRange}&bedroom=${serviceProvider.rooms}';
      } else if (serviceProvider.priceRange != null &&
          serviceProvider.rooms == null &&
          serviceProvider.bedroom == null) {
        print('step 4');
        uri = BASEURL +
            'get_properties?type=$type&property_type=${serviceProvider.priceRange}';
      } else if (serviceProvider.rooms != null &&
          serviceProvider.priceRange == null &&
          serviceProvider.bedroom == null) {
        print('step 6');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.rooms}';
      } else if (serviceProvider.bedroom != null &&
          serviceProvider.priceRange == null &&
          serviceProvider.bedroom == null) {
        print('step 7');
        uri = BASEURL +
            'get_properties?type=$type&rooms=${serviceProvider.bedroom}';
      } else if (serviceProvider.priceRange != null &&
          serviceProvider.bedroom != null &&
          serviceProvider.rooms == null) {
        print('step 9');
        uri = BASEURL +
            'get_properties?type=$type&property_type=${serviceProvider.priceRange}&range=${serviceProvider.bedroom}';
      } else if (serviceProvider.priceRange != null &&
          serviceProvider.rooms != null &&
          serviceProvider.bedroom == null) {
        print('step 10');
        uri = BASEURL +
            'get_properties?type=$type&range=${serviceProvider.priceRange}&rooms=${serviceProvider.rooms}';
      } else if (serviceProvider.rooms != null &&
          serviceProvider.bedroom != null &&
          serviceProvider.priceRange == null) {
        print('step 14');
        uri = BASEURL +
            'get_properties?type=$type&rooms=${serviceProvider.rooms}&bedroom=${serviceProvider.bedroom}';
      } else {
        print('step last');
        uri = BASEURL + 'get_properties?type=$type';
      }

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return PropertyByTypeModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getFilteredProperty(BuildContext context,
      String priceRange, String propertyType, String location) async {
    try {
      String token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL +
          'get_properties?range=$priceRange&property_type=$propertyType&type=all&location=$location';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return AllPropertiesModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getAllProperty(BuildContext context) async {
    try {
      String token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get_properties?type=all';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return AllPropertiesModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future getPropertyByType(String token, String type) async {
    try {
      final uri = BASEURL + 'get_properties?type=$type';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return PropertyByTypeModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getPortfolio(String token, String type) async {
    try {
      final uri = BASEURL + 'portfolio?type=$type';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return PortfolioModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getWalletBalance(BuildContext context) async {
    String token = Provider.of<UserToken>(context, listen: false).userToken;
    try {
      final uri = BASEURL + 'get-wallet-balance';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return WalletBalanceModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  // static Future<Object> getWalletHistory(BuildContext context) async {
  //   try {
  //     String token = Provider.of<UserToken>(context, listen: false).userToken;
  //     final uri = BASEURL + 'get-wallet-history';

  //     final response =
  //         await http.get(Uri.parse(uri), headers: setHeaders(token));

  //     final result = await jsonDecode(response.body);
  //     // logger.d('Get the data $result');

  //     if (response.statusCode == 200) {
  //       return WalletTransationHistoryModel.fromJson(result);
  //     } else {
  //       throw RepoFailure(result["message"] ?? "Try again");
  //     }
  //   } on SocketException {
  //     throw RepoFailure("No internet connection");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  static Future<Object> getPropertyHistory(
      BuildContext context, String duration) async {
    try {
      String token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get_property_transactions?type=$duration';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return TransactionHistoryModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }
  // paystack-bank-list

  // static Future<Object> getBanks(String token) async {
  //   try {
  //     final uri = BASEURL + 'get-banks';

  //     final response =
  //         await http.get(Uri.parse(uri), headers: setHeaders(token));

  //     final result = await jsonDecode(response.body);
  //     logger.d(result);

  //     if (response.statusCode == 200) {
  //       return GetBanksModel.fromJson(result);
  //     } else {
  //       throw RepoFailure(result["message"] ?? "Try again");
  //     }
  //   } on SocketException {
  //     throw RepoFailure("No internet connection");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  static Future<Object> paystackBankList(BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get-banks';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      logger.d(result);

      if (response.statusCode == 200) {
        return PaystackBankListModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getNotification(String token) async {
    try {
      final uri = BASEURL + 'notifications';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return NotificationModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getUser(BuildContext context) async {
    String token = Provider.of<UserToken>(context, listen: false).userToken;
    try {
      final uri = BASEURL + 'get-user';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(token));

      final result = await jsonDecode(response.body);
      // logger.d(result);

      if (response.statusCode == 200) {
        return UserModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getWatchList(BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get-watchlist';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      logger.d('Get list $result');

      if (response.statusCode == 200) {
        return WatchListModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getCard(BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get-cards';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      // logger.d(result);
      // logger.d(response.statusCode);

      if (response.statusCode == 200) {
        return GetCardModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getUserAccountBank(BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get-bank-accounts';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      logger.d(result);
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        return UserBankAccountModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getTickets(BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get-tickets';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      // logger.d(result);
      // logger.d(response.statusCode);

      if (response.statusCode == 200) {
        // logger.d(result['data']['tickets']);
        if (result['data']['tickets'] == 0) {
          Navigator.of(context).pushNamed(CreateTicket.routeName);
        }
        return GetAllTicketsModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getChat(ScrollController controller,
      BuildContext context, String ticketId) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get-ticket?ticket_id=$ticketId';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      logger.d(result);
      // logger.d(response.statusCode);

      if (response.statusCode == 200) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller.hasClients) {
            controller.jumpTo(controller.position.maxScrollExtent);
          }
        });
        return ChatModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getBlogPost(BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'get-blog-posts';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      logger.d(result);
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        return GetBlogPostModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }

  static Future<Object> getFee(BuildContext context) async {
    try {
      String _token = Provider.of<UserToken>(context, listen: false).userToken;
      final uri = BASEURL + 'fees';

      final response =
          await http.get(Uri.parse(uri), headers: setHeaders(_token));

      final result = await jsonDecode(response.body);
      logger.d('The fee $result');
      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        return FeeModel.fromJson(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }
}
