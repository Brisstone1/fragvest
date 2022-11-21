import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';

class PasswordSentScreen extends StatelessWidget {
  static const routeName = '/password-sent';
  const PasswordSentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: ''),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 250, child: Image.asset(imgrafiki)),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'We have sent a password recovery information to your mail',
                    style: stBlack700Rubik18,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 52),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: customButton('Go Back', () {}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
