import 'package:fragvest_mobile/provider/profile_widget_provider.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

import 'provider/complete_registration_provider.dart';

List<SingleChildWidget> proivders = [
  ChangeNotifierProvider.value(value: ProfileWidgetProvider()),
  ChangeNotifierProvider.value(value: CheckCompleteReg()),
  ChangeNotifierProvider.value(value: UserToken()),
  ChangeNotifierProvider.value(value: ServiceProvider()),
];
