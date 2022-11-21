import 'package:fragvest_mobile/model/api_response.dart';
import 'package:fragvest_mobile/model/initiate_fund_model.dart';
import 'package:fragvest_mobile/model/utility_model.dart/generic_response.dart';
import 'package:fragvest_mobile/model/wallet_transaction_history_model.dart';
import 'package:fragvest_mobile/repository/base_service.dart';

class WalletService extends BaseDatasource {
  Future<ApiResponse<WalletTransationHistoryModel>> walletHistory() async {
    final response = await sendGet(endpoint: 'get-wallet-history');
    return response
        .transform((data) => WalletTransationHistoryModel.fromJson(data));
  }

  Future<ApiResponse<InitiateFundModel>> initiateFund(String amount) async {
    final response = await sendPost(
        endpoint: 'initiate-funding', payload: {"amount": amount});
    return response.transform((data) => InitiateFundModel.fromJson(data));
  }

  Future<ApiResponse<GenericResponse>> comfirmPayment(
      String reference, num amount) async {
    final response = await sendPost(
        endpoint: 'confirm-payment',
        payload: {'reference': reference, 'amount': amount});
    return response.transform((data) => GenericResponse.fromJson(data));
  }
}
