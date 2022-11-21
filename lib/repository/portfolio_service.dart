import 'package:fragvest_mobile/model/api_response.dart';
import 'package:fragvest_mobile/model/buy_order_history_model.dart';
import 'package:fragvest_mobile/model/invest_order_history_model.dart';
import 'package:fragvest_mobile/model/rent_oder_history_model.dart';
import 'package:fragvest_mobile/model/utility_model.dart/generic_response.dart';
import 'package:fragvest_mobile/repository/base_service.dart';

class PortfolioService extends BaseDatasource {
  Future<ApiResponse<RentOderHistoryModel>> getRentOrder() async {
    final response = await sendGet(endpoint: 'sell-orders/rent');
    return response.transform((data) => RentOderHistoryModel.fromJson(data));
  }

  Future<ApiResponse<BuyOrderHistoryModel>> getBuyOrder() async {
    final response = await sendGet(endpoint: 'sell-orders/sale');
    return response.transform((data) => BuyOrderHistoryModel.fromJson(data));
  }

  Future<ApiResponse<InvestOrderHistoryModel>> getInvestOrder() async {
    final response = await sendGet(endpoint: 'sell-orders/invest');
    return response.transform((data) => InvestOrderHistoryModel.fromJson(data));
  }

  Future<ApiResponse<GenericResponse>> forfeitProperty(
      String portfolioId, String pin) async {
    final response = await sendPost(
        endpoint: 'order/forfeited',
        payload: {'portfolio_id': portfolioId, 'pin': pin});
    return response
        .transform<GenericResponse>((data) => GenericResponse.fromJson(data));
  }

  Future<ApiResponse<GenericResponse>> sellProperty(
      String portfolioId, String discount, String pin) async {
    final response = await sendPost(endpoint: 'order/sell', payload: {
      'portfolio_id': portfolioId,
      'discount': discount,
      'pin': pin
    });
    return response
        .transform<GenericResponse>((data) => GenericResponse.fromJson(data));
  }

  Future<ApiResponse<GenericResponse>> sellFrag(
      String portfolioId, String frag, String pin) async {
    final response = await sendPost(
        endpoint: 'order/sell',
        payload: {'portfolio_id': portfolioId, 'frag': frag, 'pin': pin});
    return response
        .transform<GenericResponse>((data) => GenericResponse.fromJson(data));
  }

  Future<ApiResponse<GenericResponse>> renewRent(
      String propertyId, String duration, String pin) async {
    final response = await sendPost(endpoint: 'renew-rent', payload: {
      'property_id': propertyId, 'duration': duration,
      // 'pin': pin
    });
    return response
        .transform<GenericResponse>((data) => GenericResponse.fromJson(data));
  }
}
