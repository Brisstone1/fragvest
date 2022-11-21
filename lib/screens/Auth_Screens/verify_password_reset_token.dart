import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'reset_password_screen.dart';

class VerifyPasswordResetEmailToken extends StatefulWidget {
  static const routeName = '/passord-reset';
  @override
  _VerifyPasswordResetEmailTokenState createState() =>
      _VerifyPasswordResetEmailTokenState();
}

class _VerifyPasswordResetEmailTokenState
    extends State<VerifyPasswordResetEmailToken> {
  TextEditingController _emailTokenController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;

  bool _isLoading = false;
  bool _hasError = false;
  String _currentText = "";
  final _formKey = GlobalKey<FormState>();
  String _token;
  // String _email;

  // @override
  // void initState() {

  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
    errorController = StreamController<ErrorAnimationType>();
    _token = Provider.of<UserToken>(context, listen: false).userToken;
    // _email = ModalRoute.of(context).settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    return Scaffold(
      // backgroundColor: Constants.PRIMARY_COLOR,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(imgrafiki),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Verify',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: serviceProvider.passwordVerifyEmail,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      // obscureText: true,
                      obscuringCharacter: '*',
                      // obscuringWidget: FlutterLogo(
                      //   size: 24,
                      // ),
                      // blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          inactiveColor: Colors.grey),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      // enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: _emailTokenController,
                      keyboardType: TextInputType.number,

                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        serviceProvider
                            .setPasswordResetToken(_emailTokenController.text);
                        _resetButton(serviceProvider.passwordVerifyEmail);
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        setState(() => _currentText = value);
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  _hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {},
                      // snackBar("OTP resend!!"),
                      child: Text(
                        "RESEND",
                        style: TextStyle(
                            // color: Color(0xFF91D3B3),
                            color: Color(0xFF539DBF),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: _isLoading
                    ? spinKitLoaderWidget()
                    : customButton('Reset', () {
                        serviceProvider
                            .setPasswordResetToken(_emailTokenController.text);
                        _resetButton(serviceProvider.passwordVerifyEmail);
                      }),
              ),
              TextButton(
                child: Text("Clear"),
                onPressed: () {
                  _emailTokenController.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _resetButton(String email) async {
    if (_formKey.currentState.validate()) {
      if (_currentText.length != 6) {
        errorController
            .add(ErrorAnimationType.shake); // Triggering error shake animation
        setState(() => _hasError = true);
      } else {
        setState(() {
          _isLoading = true;
        });
        final response = await PostServices.veryEmailToken(
            _token, email, _emailTokenController.text);

        setState(() {
          _isLoading = false;
        });

        if (response is RepoSucess) {
          setState(() {
            _isLoading = false;
          });
          flushbarWidget(context, 'Reset token sent successfully', true);
          Navigator.of(context).pushNamed(
            ResetPassordScreen.routeName,
          );
        } else {
          setState(() {
            _isLoading = false;
          });
          flushbarWidget(
              context, (response as RepoFailure).errorMessage, false);
        }
      }
    }
  }
}
