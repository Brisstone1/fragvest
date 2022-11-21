import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/signin_screen.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/verify_email_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isShow = false;
  bool _isComfirmShow = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _comformPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  void _showingpwd() {
    setState(() {
      _isShow = !_isShow;
    });
  }

  void _showComfirmPwd() {
    setState(() {
      _isComfirmShow = !_isComfirmShow;
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
            // height: MediaQuery.of(context).size.height * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome! Create Account Now',
                    // style: st535353500Rubik16,
                    style: TextStyle(
                      color: Color(0xFF0C0932),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Text(
                  //   'Sign Up',
                  //   style: st535353400Rubik14,
                  // ),
                  const SizedBox(height: 40),
                  Text('Email', style: textfieldStyle),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: _emailController,
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
                      // decoration: borderTextInputDecoration,
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

                  const SizedBox(height: 20),
                  Text('Password', style: textfieldStyle),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_isShow,
                      // decoration: borderTextInputDecoration.copyWith(
                      //   suffixIcon: IconButton(
                      //     icon: Icon(
                      //         !_isShow ? Icons.visibility : Icons.visibility_off),
                      //     onPressed: _showingpwd,
                      //   ),
                      // ),
                      decoration: InputDecoration(
                        hintText: "XXXXXXXXXXX",
                        suffixIcon: IconButton(
                          icon: Icon(!_isShow
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _showingpwd,
                        ),
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
                        if (val.isEmpty) {
                          return 'Password is required';
                        } else if (val.length < 8) {
                          return 'Password must contain at least 8 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Confirm Password', style: textfieldStyle),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: _comformPasswordController,
                      obscureText: !_isComfirmShow,
                      // decoration: borderTextInputDecoration.copyWith(
                      //
                      // ),
                      decoration: InputDecoration(
                        hintText: "XXXXXXXX",
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
                        suffixIcon: IconButton(
                          icon: Icon(!_isComfirmShow
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _showComfirmPwd,
                        ),
                      ),
                      validator: (String val) {
                        if (val != _passwordController.text) {
                          return 'Password do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Phone Number', style: textfieldStyle),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: "+2349034894890",
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
                      keyboardType: TextInputType.phone,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 43),
                  //Regitster User
                  _isLoading
                      ? spinKitLoaderWidget()
                      : customButton('Create Account', _registerUser),
                  const SizedBox(height: 8),
                  // RichText(
                  //   text: TextSpan(
                  //       text:
                  //           "By creating an account you agree that you have read and accepted our ",
                  //       children: [
                  //         TextSpan(
                  //           text: 'terms ',
                  //           recognizer: TapGestureRecognizer()
                  //             ..onTap = () {
                  //               _launchURL(
                  //                   'https://fragvest.com/terms-and-conditions');
                  //             },
                  //           style: textfieldStyle.copyWith(color: kc3DED97),
                  //         ),
                  //         const TextSpan(
                  //           text: 'and ',
                  //         ),
                  //         TextSpan(
                  //             text: 'privacy policy',
                  //             recognizer: TapGestureRecognizer()
                  //               ..onTap = () {
                  //                 _launchURL(
                  //                     'https://fragvest.com/privacy-policy');
                  //               },
                  //             style: textfieldStyle.copyWith(color: kc3DED97))
                  //       ],
                  //       style: textfieldStyle),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: 30,
            child: RichText(
              text: TextSpan(
                  text: "Are you an old user?",
                  children: [
                    TextSpan(
                        text: ' Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            return Navigator.of(context)
                                .pushNamed(SigninScreen.routeName);
                          },
                        style: textfieldStyle.copyWith(color: kc3DED97)),
                  ],
                  style: textfieldStyle),
            ),
          ),
        ],
      ),
    );
  }

  _registerUser() async {
    FocusScope.of(context).unfocus();
    print('Just pressed');

    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await PostServices.signupUser(context,
          email: _emailController.text,
          password: _passwordController.text,
          comfirmPassword: _comformPasswordController.text,
          phone: _phoneController.text);

      setState(() {
        _isLoading = false;
      });

      if (response is RepoSucess) {
        Navigator.of(context).pushNamed(VerifyEmailScreen.routeName);
      } else {
        setState(() {
          _isLoading = false;
        });
        flushbarWidget(context, (response as RepoFailure).errorMessage, false);
      }
    }
  }

  void _launchURL(String url) async {
    if (!await launch(url))
      flushbarWidget(context, 'Could not launch $url', false);
  }
}
