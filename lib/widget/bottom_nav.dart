import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/screens/dashboard/dashboard_screen.dart';
import 'package:fragvest_mobile/screens/market/market_screen.dart';
import 'package:fragvest_mobile/screens/portfolio/portfolio_screen.dart';
import 'package:fragvest_mobile/screens/profile_screen.dart';
import 'package:fragvest_mobile/screens/property_upload_screen.dart';
import 'package:fragvest_mobile/utilities/nav_bars_items.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomNav extends StatefulWidget {
  static const routeName = '/bottom-nav';
  const BottomNav({Key key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentTab = 0;
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  // List<Widget> _buildScreens() {
  //   return [
  //     DashbordScreen(),
  //     PortFolioScreen(),
  //     PropertyScreen(),
  //     MarketScreen(),
  //     ProfileScreen()
  //   ];
  // }

  List<Widget> _bodyIem = [
    DashbordScreen(),
    PortFolioScreen(),
    MarketScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return CurvedNavBar(
      actionButton: actionButton(),
      // activeColor: Colors.blue,
      // navBarBackgroundColor: Colors.limeAccent,
      // inActiveColor: Colors.black45,
      appBarItems: appBarItems(),
      bodyItems: _bodyIem,

      actionBarView: PropertyUploadScreen(),
      // Container(
      //   height: MediaQuery.of(context).size.height,
      //   color: Colors.orange,
      // ),
    );

    // Scaffold(
    //   body: PersistentTabView(
    //     context,
    //     controller: _controller,
    //     screens: _buildScreens(),
    //     items: navBarsItems(),
    //     confineInSafeArea: true,
    //     backgroundColor: Colors.white,
    //     handleAndroidBackButtonPress: true,
    //     resizeToAvoidBottomInset: true,
    //     stateManagement: true,
    //     navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
    //         ? 0.0
    //         : kBottomNavigationBarHeight,
    //     hideNavigationBarWhenKeyboardShows: true,
    //     margin: EdgeInsets.all(0.0),
    //     popActionScreens: PopActionScreensType.all,
    //     bottomScreenMargin: 0.0,
    //     // onWillPop: (context) async {
    //     //   await showDialog(
    //     //     context: context,
    //     //     useSafeArea: true,
    //     //     builder: (context) => Container(
    //     //       height: 50.0,
    //     //       width: 50.0,
    //     //       color: Colors.white,
    //     //       child: ElevatedButton(
    //     //         child: Text("Close"),
    //     //         onPressed: () {
    //     //           Navigator.pop(context);
    //     //         },
    //     //       ),
    //     //     ),
    //     //   );
    //     //   return false;
    //     // },
    //     selectedTabScreenContext: (context) {
    //       // testContext = context;
    //     },
    //     hideNavigationBar: _hideNavBar,
    //     decoration: NavBarDecoration(
    //         colorBehindNavBar: Colors.indigo,
    //         borderRadius: BorderRadius.circular(20.0)),
    //     popAllScreensOnTapOfSelectedTab: true,
    //     itemAnimationProperties: ItemAnimationProperties(
    //       duration: Duration(milliseconds: 400),
    //       curve: Curves.ease,
    //     ),
    //     screenTransitionAnimation: ScreenTransitionAnimation(
    //       animateTabTransition: true,
    //       curve: Curves.ease,
    //       duration: Duration(milliseconds: 200),
    //     ),
    //     navBarStyle:
    //         NavBarStyle.style15, // Choose the nav bar style with this property
    //   ),
    // );
  }
}
