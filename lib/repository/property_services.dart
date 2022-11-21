import 'package:fragvest_mobile/model/api_response.dart';
import 'package:fragvest_mobile/model/available_states_model.dart';
import 'package:fragvest_mobile/repository/base_service.dart';

class PropertyServices extends BaseDatasource {
  Future<ApiResponse<AvailableStatesModel>> getAvailableState() async {
    final response = await sendGet(endpoint: 'availabe_states/all');
    return response.transform((data) => AvailableStatesModel.fromJson(data));
  }
}
