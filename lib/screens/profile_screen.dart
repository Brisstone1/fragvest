import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/profile_widget_provider.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/support/tickets_screen.dart';
import 'package:fragvest_mobile/screens/wallet/wallet_home.dart';
import 'package:fragvest_mobile/screens/watchlist/watch_list_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/bottom_nav.dart';
import 'package:fragvest_mobile/widget/dommy_avater_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:provider/provider.dart';

import 'Auth_Screens/signin_screen.dart';
import 'accoun_setting_screen.dart';
import 'notification_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _token;
  @override
  void initState() {
    _token = Provider.of<UserToken>(context, listen: false).userToken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();

    final _profileItem =
        Provider.of<ProfileWidgetProvider>(context).profileItem;
    return Scaffold(
        backgroundColor: kc0C0932,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kc0C0932,
          elevation: 0,
          toolbarHeight: 30,
        ),
        body: Column(
          children: [
            ListTile(
              leading: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AccountSettingScreen.routeName);
                },
                child: profileImage(serviceProvider.imageUrl),
              ),
              // leading: profileImage(serviceProvider.imageUrl),
              title: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AccountSettingScreen.routeName);
                  },
                  child: Text(
                      '${serviceProvider?.firstName?.replaceFirst(serviceProvider?.firstName[0], serviceProvider?.firstName[0]?.toUpperCase())} ${serviceProvider?.lastName?.replaceFirst(serviceProvider?.lastName[0], serviceProvider?.lastName[0].toUpperCase())}',
                      style: stFFFFFF500Rubik18)),

              subtitle: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AccountSettingScreen.routeName);
                  },
                  child:
                      Text(serviceProvider.email, style: stFFFFFF400Rubik12)),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 40, left: 30),
                  itemCount: _profileItem.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        index == 0
                            ? Navigator.of(context).pushNamedAndRemoveUntil(
                                BottomNav.routeName, (route) => false)
                            : index == 1
                                ? Navigator.of(context)
                                    .pushNamed(WalletHome.routeName)
                                : index == 2
                                    ? Navigator.of(context)
                                        .pushNamed(NotificationScreen.routeName)
                                    : index == 3
                                        ? Navigator.of(context).pushNamed(
                                            WatchListScreen.routeName)
                                        : index == 4
                                            ? Navigator.of(context).pushNamed(
                                                TicketScreen.routeName,
                                                arguments: false)

                                            // Navigator.of(context).pushNamed(
                                            //     CreateTicket.routeName)
                                            : index == 5
                                                ? Navigator.of(context)
                                                    .pushNamed(
                                                        AccountSettingScreen
                                                            .routeName)
                                                : index == 6
                                                    ? _signOut(context)
                                                    : print('object');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Row(
                          children: [
                            Image.asset(
                              _profileItem[index].image,
                              height: 20,
                            ),
                            SizedBox(width: 10),
                            Text(_profileItem[index].title,
                                style: stFFFFFF500Rubik16)
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }

  _signOut(BuildContext context) async {
    // AwesomeDialog(
    //   context: context,
    //   dialogType: DialogType.WARNING,
    //   // animType: AnimType.BOTTOMSLIDE,
    //   title: 'Signout!!!',
    //   desc: 'Go ahead and sign me out',
    //   btnCancelOnPress: () {},
    //   btnOkOnPress: () async {
    //     await _submitButton();
    //   },
    // )..show();
    showMaterialModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              height: 238,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // st535353600Rubik16
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Column(
                children: [
                  Image.asset(homeIndicator),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirm Log out',
                      style: TextStyle(
                          color: Color(0xFF0C0932),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 24, bottom: 56),
                    child: Text(
                      "Are you sure you want to log out?",
                      style: TextStyle(
                        color: Color(0xFF535353),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: MaterialButton(
                      color: Color(0xFFFE4E4E),
                      onPressed: () async {
                        await _submitButton();
                      },
                      child: Text('Log out',
                          style: st535353600Rubik16.copyWith(
                              color: kcWhite, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ));
        });
  }

  _submitButton() async {
    final response = await PostServices.logoutUser(
      _token,
    );

    if (response is RepoSucess) {
      Navigator.pushNamedAndRemoveUntil(
          context, SigninScreen.routeName, (Route<dynamic> route) => false);
    } else {
      flushbarWidget(context, (response as RepoFailure).errorMessage, false);
    }
  }
}
