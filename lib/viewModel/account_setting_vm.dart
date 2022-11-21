import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/model/user_model.dart';
import 'package:fragvest_mobile/repository/account_setting_service.dart';
import 'package:fragvest_mobile/utilities/logger_util.dart';
import 'package:fragvest_mobile/viewModel/base_view_model.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';

import '../screens/Auth_Screens/signin_screen.dart';

class AccountSettingVm extends BaseViewModel {
  UserModel cachedUserModel;
  bool isUserLoadingError = false;
  String userError;

  final profileService = getIt.get<AccountSettingService>();

  Future<void> getUser(BuildContext context) async {
    final result = await profileService.getUser();

    if (result.hasError) {
      isUserLoadingError = true;
      userError = result.error.toString();
      logger.d(userError);
      setState();
      // flushbarWidget(context, result.error.toString(), false);
    } else {
      cachedUserModel = result.data;
      setState();
    }
  }

  Future<void> deleteAccount(BuildContext context, String password) async {
    EasyLoading.show(status: 'Deleting account...');
    final result = await profileService.deleteAccount(password);
    EasyLoading.dismiss();
    if (result.hasError) {
      flushbarWidget(context, result.error.toString(), false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, SigninScreen.routeName, (Route<dynamic> route) => false);
    }
  }
}
