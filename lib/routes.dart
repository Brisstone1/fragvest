import 'package:flutter/material.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/change_password.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/forgot_password_screen.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/verify_email_screen.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/verify_password_reset_token.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/reset_password_screen.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/signin_screen.dart';
import 'package:fragvest_mobile/screens/accoun_setting_screen.dart';
import 'package:fragvest_mobile/screens/complete_trending_property_review.dart';
import 'package:fragvest_mobile/screens/market/r_s_i_filter_result.dart';
import 'package:fragvest_mobile/screens/portfolio/order_screen.dart';
import 'package:fragvest_mobile/screens/portfolio/renew_rent.dart';
import 'package:fragvest_mobile/screens/portfolio/sell_asset.dart';
import 'package:fragvest_mobile/screens/watchlist/complete_review/property_complete_review.dart';
import 'package:fragvest_mobile/screens/support/create_ticket.dart';
import 'package:fragvest_mobile/screens/support/support_chat_screen.dart';
import 'package:fragvest_mobile/screens/support/tickets_screen.dart';
import 'package:fragvest_mobile/screens/tour/tour_sucess.dart';
import 'package:fragvest_mobile/screens/verification_screen.dart';
import 'package:fragvest_mobile/screens/wallet/add_new_card.dart';
import 'package:fragvest_mobile/screens/wallet/pay_via_bank.dart';
import 'package:fragvest_mobile/screens/wallet/security_pin_screen.dart';
import 'package:fragvest_mobile/screens/wallet/top_up_screen.dart';
import 'package:fragvest_mobile/screens/wallet/wallet_home.dart';
import 'package:fragvest_mobile/screens/wallet/withdrawal_screen.dart';
import 'package:fragvest_mobile/screens/watchlist/watch_list_screen.dart';
import 'package:fragvest_mobile/widget/bottom_nav.dart';
import 'screens/Auth_Screens/complete_signup_screen.dart';
import 'screens/Auth_Screens/signup_screen.dart';
import 'screens/Auth_Screens/token_verifiaction_screen.dart';
import 'screens/dashboard/all_portfolio_screen.dart';
import 'screens/dashboard/all_trending_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/payment/payment_option_screen.dart';
import 'screens/wallet/add_new_account.dart';
import 'screens/wallet/all_transaction_history_screen.dart';

final routes = <String, WidgetBuilder>{
  SigninScreen.routeName: (_) {
    return SigninScreen();
  },
  SignUpScreen.routeName: (_) {
    return SignUpScreen();
  },
  CompleteSignUpScreen.routeName: (_) {
    return CompleteSignUpScreen();
  },
  ForgotPasswordScreen.routeName: (_) {
    return ForgotPasswordScreen();
  },
  ResetPassordScreen.routeName: (_) {
    return ResetPassordScreen();
  },
  BottomNav.routeName: (_) {
    return BottomNav();
  },
  NotificationScreen.routeName: (_) {
    return NotificationScreen();
  },
  AllTrendingScreen.routeName: (_) {
    return AllTrendingScreen();
  },
  AllPortfolioScreen.routeName: (_) {
    return AllPortfolioScreen();
  },
  // AllNewfeedScreen.routeName: (_) {
  //   return AllNewfeedScreen();
  // },
  // RentSaleInvestFilterScreen.routeName: (_) {
  //   return RentSaleInvestFilterScreen();
  // },
  // PropertyDetail.routeName: (_) {
  //   return PropertyDetail();
  // },
  AccountSettingScreen.routeName: (_) {
    return AccountSettingScreen();
  },
  VerificationScreen.routeName: (_) {
    return VerificationScreen();
  },
  PaymentOptionScreen.routeName: (_) {
    return PaymentOptionScreen();
  },
  AllTransactionHistoryScreen.routeName: (_) {
    return AllTransactionHistoryScreen();
  },
  AddNewAccountScreen.routeName: (_) {
    return AddNewAccountScreen();
  },
  AddNewCarScreen.routeName: (_) {
    return AddNewCarScreen();
  },
  TopUpScreen.routeName: (_) {
    return TopUpScreen();
  },
  VerifyPasswordResetEmailToken.routeName: (_) {
    return VerifyPasswordResetEmailToken();
  },
  WalletHome.routeName: (_) {
    return WalletHome();
  },
  SecurityPinScreen.routeName: (_) {
    return SecurityPinScreen();
  },
  WatchListScreen.routeName: (_) {
    return WatchListScreen();
  },

  PropertCompleteReview.routeName: (_) {
    return PropertCompleteReview();
  },
  CompletePropertyTrendingReview.routeName: (_) {
    return CompletePropertyTrendingReview();
  },

  TourSucessScreen.routeName: (_) {
    return TourSucessScreen();
  },

  ChangePassword.routeName: (_) {
    return ChangePassword();
  },

  TicketScreen.routeName: (_) {
    return TicketScreen();
  },

  CreateTicket.routeName: (_) {
    return CreateTicket();
  },

  SupportChatScreen.routeName: (_) {
    return SupportChatScreen();
  },

  TokenVerificationScreen.routeName: (_) {
    return TokenVerificationScreen();
  },

  VerifyEmailScreen.routeName: (_) {
    return VerifyEmailScreen();
  },

  // RSICompleteReview.routeName: (_) {
  //   return RSICompleteReview();
  // },

  PayViaBankScreen.routeName: (_) {
    return PayViaBankScreen();
  },
  // FilterResultScreen.routeName: (_) {
  //   return FilterResultScreen();
  // },

  RSIFilterResult.routeName: (_) {
    return RSIFilterResult();
  },

  WithdrawalScreen.routeName: (_) {
    return WithdrawalScreen();
  },

  OrderScreen.routeName: (_) {
    return OrderScreen();
  },

  SellAssetsScreen.routeName: (_) {
    return SellAssetsScreen();
  },

  RenewRentScreen.routeName: (_) {
    return RenewRentScreen();
  }
};
