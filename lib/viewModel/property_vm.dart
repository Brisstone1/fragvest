import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/model/available_states_model.dart';
import 'package:fragvest_mobile/repository/property_services.dart';
import 'package:fragvest_mobile/viewModel/base_view_model.dart';

class PropertyVm extends BaseViewModel {
  final propertyService = getIt.get<PropertyServices>();
  AvailableStatesModel availableStatesModel;
  StateData selectedState;

  String stateLoadStatus = 'initial';
  String stateLoadError = '';

  Future<void> getAvailableStates() async {
    final result = await propertyService.getAvailableState();
    if (result.hasError) {
      stateLoadStatus = 'failed';
      stateLoadError = result.error.toString() ?? "Error occored";
      setState();
    } else {
      stateLoadStatus = 'seccess';
      availableStatesModel = result.data;
      setState();
    }
  }

  setSelectedState(StateData states) {
    selectedState = states;
    setState();
  }

  onDispose() {
    selectedState = null;
  }
}
