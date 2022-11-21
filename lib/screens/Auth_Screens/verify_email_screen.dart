import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/signin_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const routeName = '/verify-email-screen';

  const VerifyEmailScreen({Key key}) : super(key: key);
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  // @override
  // void initState() {
  //   SystemChrome.setPreferredOrientations(
  //       [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  //   super.initState();
  // }
  bool _isLoading = false;
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Container(
              margin: const EdgeInsets.only(bottom: 40),
              height: 190,
              child: Image.asset(
                imgEmail,
                fit: BoxFit.contain,
              )),
          Text(
            'Verify your Email',
            textAlign: TextAlign.center,
            style: stBlue600Rubik18,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'You can check your mailbox, we have sent you a link to help us verify your email address',
              style: st535353400Rubik14.copyWith(color: kc535353),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          customButton('Proceed',
              () => Navigator.of(context).pushNamed(SigninScreen.routeName)),
          MaterialButton(
            onPressed: () {
              _userLogin();
            },
            child: Text(_isLoading ? 'Sending' : 'Resend verification link?',
                style: st3DED97400Rubik11),
          ),
        ],
      ),
    );
  }

  _userLogin() async {
    FocusScope.of(context).unfocus();
    print('Just pressed');

    // if (_formKey.currentState.validate()) {
    setState(() {
      _isLoading = true;
    });

    final response = await PostServices.resendVerificationMail(context);

    setState(() {
      _isLoading = false;
    });


    if (response.toString() == "Verification link has been sent to your email") {
      flushbarWidget(context, "Email Resent", true);
    } else {
      setState(() {
        _isLoading = false;
      });
      flushbarWidget(context, "Try Again", false);
    }
  }
}
