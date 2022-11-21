import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';

List<FABBottomAppBarItem> appBarItems() {
  return [
    FABBottomAppBarItem(
      activeIcon: _icon2(imgHome1),
      inActiveIcon: _icon(imgHome),
      text: '',
    ),
    FABBottomAppBarItem(
        activeIcon: _icon2(imgGraph1), inActiveIcon: _icon(imgGraph), text: ''),
    FABBottomAppBarItem(
        activeIcon: _icon2(imgBuy1), inActiveIcon: _icon(imgBuy), text: ''),
    FABBottomAppBarItem(
        activeIcon: _icon2(imgProfile2),
        inActiveIcon: _icon(imgProfile),
        text: ''),
    // PersistentBottomNavBarItem(
    //     icon: _icon(imgHome1), inactiveIcon: _icon(imgHome)),
    // PersistentBottomNavBarItem(
    //     icon: _icon(imgGraph1), inactiveIcon: _icon(imgGraph)),
    // PersistentBottomNavBarItem(
    //   activeColorPrimary: kcWhite,
    //   icon: Image.asset(
    //     imgPersitAdd,
    //     fit: BoxFit.fill,
    //   ),
    // inactiveIcon: Image.asset(
    //   imgPersitAdd,
    //   fit: BoxFit.fill,
    // ),

    // ),
    // PersistentBottomNavBarItem(
    //     icon: _icon(imgBuy1), inactiveIcon: _icon(imgBuy)),
    // PersistentBottomNavBarItem(
    //     icon: _icon(imgProfile), inactiveIcon: _icon(imgProfile)),
  ];
}

CurvedActionBar actionButton() {
  return CurvedActionBar(
    onTab: (value) {
      /// perform action here
      print(value);
    },
    activeIcon: Image.asset(
      imgPersitAdd,
      height: 66,
      fit: BoxFit.fill,
    ),
    inActiveIcon: Image.asset(
      imgPersitAdd,
      height: 66,
      fit: BoxFit.fill,
    ),
    // text: "Camera"
  );
}

Widget _icon(String image) {
  return Container(
    height: 24,
    width: 24,
    child: Image.asset(image),
  );
}

Widget _icon2(String image) {
  return Container(

    alignment: Alignment.center,
    child: Column(
      children: [
        Image.asset(image, width: 20, height: 20,),
        SizedBox(height:6),
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: Color(0xFF07c168),
            borderRadius: BorderRadius.circular(100)
          ),
          // child: ,
        )
      ],
    ),
  );
}
