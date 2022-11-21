import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/complete_signup_screen.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/forgot_password_screen.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/signup_screen.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/verify_email_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/bottom_nav.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = '/signin-screen';
  // const SigninScreen({Key key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isShow = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  void _showingpwd() {
    setState(() {
      _isShow = !_isShow;
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: ''),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome! Login Now',
                    // style: st535353500Rubik16,
                    style: TextStyle(
                      color: Color(0xFF0C0932),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15),
                  // Text(
                  //   'Sign In',
                  //   style: st535353400Rubik14,
                  // ),
                  SizedBox(height: 50),
                  Text('Email', style: textfieldStyle),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: _emailController,
                      // decoration: borderTextInputDecoration,
                      decoration: InputDecoration(
                        hintText: "example@quickr.com",
                        hintStyle:
                            TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
                        filled: true, //<-- SEE HERE
                        fillColor: Color(0xFFF5F5F8),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                          borderRadius: BorderRadius.circular(5.0),
                          //<-- SEE HERE
                        ),
                      ),
                      validator: (String val) {
                        if (val.trim().isEmpty) {
                          return 'Email required';
                        } else if (!val.trim().contains('@') ||
                            !val.trim().contains('.com')) {
                          return 'Inavlid email';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 25),
                  Text('Password', style: textfieldStyle),
                  SizedBox(height: 5),
                  SizedBox(
                      height: 44,
                      child: TextFormField(
                        controller: _pwdController,
                        obscureText: !_isShow,
                        decoration: InputDecoration(
                          hintText: "XXXXXXXX",
                          hintStyle: TextStyle(
                              fontSize: 12.0, color: Color(0xFF969595)),
                          filled: true, //<-- SEE HERE
                          fillColor: Color(0xFFF5F5F8),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                            borderRadius: BorderRadius.circular(5.0),
                            //<-- SEE HERE
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(!_isShow
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: _showingpwd,
                          ),
                        ),
                        // decoration: borderTextInputDecoration.copyWith(
                        //
                        // ),
                        validator: (String val) {
                          if (val.isEmpty) {
                            return 'Password required';
                          }
                          return null;
                        },
                      )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Transform.translate(
                        offset: Offset(14, -5),
                        child: MaterialButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(ForgotPasswordScreen.routeName),
                            child: Text(
                              'forgot password?',
                              style: TextStyle(
                                color: Color(0xFF969595),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      )),
                  SizedBox(height: 43),
                  _isLoading
                      ? spinKitLoaderWidget()
                      : customButton('Sign In', _userLogin),
                  // customButton('Sign in', () {
                  //   Navigator.of(context).pushNamed(BottomNav.routeName);
                  // })
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    alignment: Alignment.topCenter,
                    height: 30,
                    child: RichText(
                      text: TextSpan(
                          text: "Don’t  have an account? ",
                          children: [
                            TextSpan(
                                text: ' Sign Up',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    return Navigator.of(context)
                                        .pushNamed(SignUpScreen.routeName);
                                  },
                                style:
                                    textfieldStyle.copyWith(color: kc3DED97)),
                          ],
                          style: textfieldStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _userLogin() async {
    print('Just pressed');
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      final response = await PostServices.loginUser(
        context: context,
        email: _emailController.text,
        password: _pwdController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (response is LogSucess) {
        print(response.message);
        if (response.message == 'unverified') {
          Navigator.of(context).pushNamedAndRemoveUntil(
              VerifyEmailScreen.routeName, (Route<dynamic> route) => false);
        } else {
          if (response.message == 'deleted') {
            flushbarWidget(context, 'User dose not exit.', false);
          } else if (response.message == '1') {
            Navigator.of(context).pushNamedAndRemoveUntil(
                BottomNav.routeName, (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushNamed(CompleteSignUpScreen.routeName);
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        flushbarWidget(context, (response as LogFailure).errorMessage, false);
      }
    }
  }
}
