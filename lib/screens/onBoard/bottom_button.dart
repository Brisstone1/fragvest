import 'package:flutter/material.dart';

import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/signup_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class BottomButtons extends StatelessWidget {
  final int currentIndex;
  final int dataLength;
  final PageController controller;

  const BottomButtons(
      {Key key, this.currentIndex, this.dataLength, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: currentIndex == dataLength - 1
          ? [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _containerButton(
                      "Get Started",
                      context,
                      () => Navigator.of(context)
                          .pushNamed(SignUpScreen.routeName),
                      0.35)
                ],
              )
            ]
          : [
              currentIndex == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _containerButton(
                            "Proceed",
                            context,
                            () => controller.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut),
                            0.5)
                      ],
                    )
                  : Column(
                      children: [
                        _containerButton(
                            "Proceed",
                            context,
                            () => controller.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut),
                            0.5)
                      ],
                    ),
            ],
    );
  }

  Widget _containerButton(
      String text, BuildContext context, Function function, double innerWidth) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: MaterialButton(
        onPressed: function,
        color: kc3DED97,
        height: MediaQuery.of(context).size.height * 0.1,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // add this
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), side: BorderSide.none),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Text(
            text,
            style: btnStyle,
          ),
        ),
      ),
    );
  }
}
