import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/account_setting_vm.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/sucess_bottom_modal_sheet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class SecurityPinScreen extends StatefulWidget {
  static const routeName = '/security-pin';
  @override
  _SecurityPinScreenState createState() => _SecurityPinScreenState();
}

class _SecurityPinScreenState extends State<SecurityPinScreen> {
  StreamController<ErrorAnimationType> errorController;

  bool _isLoading = false;
  String _token;
  String argurment;

  List<String> _pinCode = [];
  int _pinLength = 4;
  @override
  void didChangeDependencies() {
    errorController = StreamController<ErrorAnimationType>();
    _token = Provider.of<UserToken>(context, listen: false).userToken;
    argurment = ModalRoute.of(context).settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Security Pin', true),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(imgKey),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Set security pin',
                        style: st000000500Roboto,
                        textAlign: TextAlign.center,
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
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  Column(
                    children: [
                      const SpinKitFadingCircle(
                        color: kc3DED97,
                        size: 45.0,
                      ),
                    ],
                  ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Keep your pin secured!",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
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

  _setSecurityPin() async {
    EasyLoading.show(status: 'Setting Pin');
    final response = await PostServices.securityPin(_token, _pinCode.join());

    if (response is LogSucess) {
      EasyLoading.dismiss();
      showBottmModelShweet(context, response.message);
    } else {
      EasyLoading.dismiss();
      flushbarWidget(context, (response as LogFailure).errorMessage, false);
    }
  }

  _onCompleteEvent() {
    if (_pinCode.length == 4) {
      if (argurment == 'set-pin') {
        _setSecurityPin();
      } else if (argurment == 'delete') {
        getIt.get<AccountSettingVm>().deleteAccount(context, _pinCode.join());
      }
    }
  }
}
