import 'package:flutter/foundation.dart';
import 'package:fragvest_mobile/model/api_response.dart';

enum ViewState { busy, done, error, none, noInternet }

class BaseViewModel with ChangeNotifier {
  ViewState viewState = ViewState.none;
  String viewMessage = '';
  String errorMessage = '';
  bool _disposed = false;

  bool get hasEncounteredError =>
      viewState == ViewState.error || viewState == ViewState.noInternet;
  bool get isBusy => viewState == ViewState.done;

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  void setState({ViewState viewState, String viewMessage}) {
    if (viewState != null) this.viewState = viewState;
    if (viewMessage != null) this.viewMessage = viewMessage;
    if (!_disposed) notifyListeners();
  }

  void retry(AsyncValueGetter<ApiResponse> onRetry) async {
    setState(viewState: ViewState.busy);
    final result = await onRetry();
    if (result.hasError) {
      errorMessage = result.error.toString();
    }
    setState(viewState: ViewState.error);
  }
}
