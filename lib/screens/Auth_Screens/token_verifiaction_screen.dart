import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/signin_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:provider/provider.dart';

class TokenVerificationScreen extends StatefulWidget {
  // final
  static const routeName = '/verify-token';
  @override
  _TokenVerificationScreenState createState() =>
      _TokenVerificationScreenState();
}

class _TokenVerificationScreenState extends State<TokenVerificationScreen> {
  List<String> _pinCode = [];

  @override
  Widget build(BuildContext context) {
    String _signupEmail = context.watch<ServiceProvider>().signupEmail;
    return Scaffold(
      appBar: customAppBar('', true),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Please enter the token code that was sent to your mail $_signupEmail',
                          style: st000000500Roboto,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(imgKey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          _pinCode.length < 1
                              ? Icons.radio_button_off
                              : Icons.lens,
                          size: 20),
                      SizedBox(width: 10.0),
                      Icon(
                          _pinCode.length < 2
                              ? Icons.radio_button_off
                              : Icons.lens,
                          size: 20),
                      SizedBox(width: 10.0),
                      Icon(
                          _pinCode.length < 3
                              ? Icons.radio_button_off
                              : Icons.lens,
                          size: 20),
                      SizedBox(width: 10.0),
                      Icon(
                          _pinCode.length < 4
                              ? Icons.radio_button_off
                              : Icons.lens,
                          size: 20)
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  // width: MediaQuery.of(context).size.width * 0.7,
                  width: 280,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _keyboardKeys('1', () {
                            String one = '1';
                            setState(() {
                              _pinCode.add(one);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          }),
                          _keyboardKeys('2', () {
                            String two = '2';
                            setState(() {
                              _pinCode.add(two);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          }),
                          _keyboardKeys('3', () {
                            String three = '3';
                            setState(() {
                              _pinCode.add(three);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _keyboardKeys('4', () {
                            String four = '4';
                            setState(() {
                              _pinCode.add(four);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          }),
                          _keyboardKeys('5', () {
                            String five = '5';
                            setState(() {
                              _pinCode.add(five);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          }),
                          _keyboardKeys('6', () {
                            String six = '6';
                            setState(() {
                              _pinCode.add(six);

                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _keyboardKeys('7', () {
                            String seven = '7';
                            setState(() {
                              _pinCode.add(seven);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          }),
                          _keyboardKeys('8', () {
                            String eight = '8';
                            setState(() {
                              _pinCode.add(eight);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          }),
                          _keyboardKeys('9', () {
                            String nine = '9';
                            setState(() {
                              _pinCode.add(nine);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 90,
                          ),
                          _keyboardKeys('0', () {
                            String zero = '0';
                            setState(() {
                              _pinCode.add(zero);
                              _pinCode.join();
                              _onCompleteEvent();
                            });
                          }),
                          _clearbutton(() {
                            setState(() {
                              _pinCode = [];
                            });
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _keyboardKeys(String text, VoidCallback callback) {
    return MaterialButton(
      onPressed: _pinCode.length < 4 ? callback : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kcC4C4C4.withOpacity(0.5))),
        child: Text(text, style: st000000400Roboto36),
      ),
    );
  }

  Widget _clearbutton(VoidCallback callback) {
    return MaterialButton(
      onPressed: callback,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kcC4C4C4.withOpacity(0.5))),
          child: Icon(Icons.backspace_outlined)),
    );
  }

  _verifyToken() async {
    EasyLoading.show(status: 'Just a moment...');
    final response = await PostServices.securityPin('_token', _pinCode.join());

    if (response is LogSucess) {
      EasyLoading.dismiss();
      // showBottmModelShweet(context, response.message);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(SigninScreen.routeName, (route) => false);
    } else {
      EasyLoading.dismiss();
      flushbarWidget(context, (response as LogFailure).errorMessage, false);
    }
  }

  _onCompleteEvent() {
    if (_pinCode.length == 4) {
      _verifyToken();
    }
  }
}
