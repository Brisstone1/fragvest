import 'package:fragvest_mobile/model/api_response.dart';
import 'package:fragvest_mobile/model/user_model.dart';
import 'package:fragvest_mobile/model/utility_model.dart/generic_response.dart';
import 'package:fragvest_mobile/repository/base_service.dart';

class AccountSettingService extends BaseDatasource {
  Future<ApiResponse<GenericResponse>> deleteAccount(String password) async {
    final response =
        await sendPost(endpoint: 'delete-account', payload: {'pin': password});
    return response
        .transform<GenericResponse>((data) => GenericResponse.fromJson(data));
  }

  Future<ApiResponse<UserModel>> getUser() async {
    final response = await sendGet(endpoint: 'get-user');
    return response.transform<UserModel>((data) => UserModel.fromJson(data));
  }
}
