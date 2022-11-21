import 'package:fragvest_mobile/repository/base_service.dart';
import 'package:fragvest_mobile/repository/local_storage.dart';
import 'package:fragvest_mobile/repository/account_setting_service.dart';
import 'package:fragvest_mobile/repository/portfolio_service.dart';
import 'package:fragvest_mobile/repository/property_services.dart';
import 'package:fragvest_mobile/repository/wallet_service.dart';
import 'package:fragvest_mobile/viewModel/base_view_model.dart';
import 'package:fragvest_mobile/viewModel/account_setting_vm.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/viewModel/property_vm.dart';
import 'package:fragvest_mobile/viewModel/wallet_mv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<LocalStorage>(LocalStorage(sharedPreferences));

  //Base Classes
  getIt.registerSingleton<BaseDatasource>(BaseDatasource());
  getIt.registerSingleton<BaseViewModel>(BaseViewModel());

  //Service Classes
  getIt.registerSingleton<AccountSettingService>(AccountSettingService());
  getIt.registerSingleton<PortfolioService>(PortfolioService());
  getIt.registerSingleton<PropertyServices>(PropertyServices());
  getIt.registerSingleton<WalletService>(WalletService());

  //View Model class
  getIt.registerSingleton<AccountSettingVm>(AccountSettingVm());
  getIt.registerSingleton<PortfolioVm>(PortfolioVm());
  getIt.registerSingleton<PropertyVm>(PropertyVm());
  getIt.registerSingleton<WalletMv>(WalletMv());
}
