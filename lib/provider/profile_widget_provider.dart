import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/model/profile_widget_model.dart';
import 'package:flutter/foundation.dart';

class ProfileWidgetProvider with ChangeNotifier {
  List<ProfileWidgetModel> profileItem = [
    ProfileWidgetModel(title: 'Dashboard', image: imgCategory),
    ProfileWidgetModel(title: 'My Wallets', image: imgWallet),
    ProfileWidgetModel(title: 'Notification', image: imgNotification),
    ProfileWidgetModel(title: 'Watchlist', image: imgHeart),
    ProfileWidgetModel(title: 'Help & Support', image: imgCallSilent),
    ProfileWidgetModel(title: 'Account Settings', image: imgAddUser),
    ProfileWidgetModel(title: 'Log out', image: imgLogout)
  ];
}
