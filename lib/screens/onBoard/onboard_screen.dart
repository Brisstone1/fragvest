import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/signin_screen.dart';
import 'package:fragvest_mobile/utilities/onboard_data.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

import 'bottom_button.dart';
import 'explanation_page.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  final _controller = PageController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: kc3DED97
    ));
    return SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //
          //   systemOverlayStyle: const SystemUiOverlayStyle(
          //
          //     // Status bar color
          //
          //     statusBarColor: Colors.red,
          //
          //     // Status bar brightness (optional)
          //
          //     statusBarIconBrightness: Brightness.dark,
          //
          //     // For Android (dark icons)
          //
          //     statusBarBrightness: Brightness.light, // For iO
          //
          //   ),
          //
          //
          //   elevation: 0,
          //   bottomOpacity: 0,
          //
          //   backgroundColor: Colors.red,
          //
          // ),

          // extendBodyBehindAppBar: true,
      body: Container(
        alignment: Alignment.center,
        child: Column(children: [
          Expanded(
          // flex: 2,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                        // color: Colors.red,
                        // padding: const EdgeInsets.all(0),
                        alignment: Alignment.center,
                        child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: _controller,
                            onPageChanged: (value) {
                              // _painter.changeIndex(value);
                              setState(() {
                                _currentIndex = value;
                              });
                            },
                            children: onBoardData
                                .map((e) => ExplanationPage(model: e))
                                .toList()
                        )
                    ),
                   ),
                Column(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Flexible(flex: 1, child:Container(color:Colors.red)),
                    Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(onBoardData.length,
                              (index) => createCircle(index: index)),
                        )),
                    BottomButtons(
                      currentIndex: _currentIndex,
                      dataLength: onBoardData.length,
                      controller: _controller,
                    ),

                  ],
                )
              ],
            ),
          ),
          Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
            child: MaterialButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(SigninScreen.routeName),
              child: Text(
                'Skip',
                style: stBlack700Rubik17,
              ),
            ),
          )
        ]),
      ),
    ));
  }

  createCircle({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 4),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: _currentIndex == index ? kc3DED97 : kcWhite,
        border: Border.all(color: _currentIndex == index ? kc3DED97 : kc535353),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
