import 'package:flutter/material.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/verify_password_reset_token.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password';
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  String token;
  ServiceProvider serviceProvider;

  @override
  void initState() {
    token = Provider.of<UserToken>(context, listen: false).userToken;
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Forgot Password', style: st535353700Rubik16),
                ),

                SizedBox(height: 50),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Email', style: textfieldStyle),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "example@quickr.com",
                    hintStyle: TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
                    filled: true, //<-- SEE HERE
                    fillColor: Color(0xFFF5F5F8),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 5,
                          color: Color(0xFFF5F5F8)
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                      //<-- SEE HERE
                    ),
                  ),

                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'Field is required';
                    } else if (!val.trim().contains('@') ||
                        !val.trim().contains('.com')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 52),
                _isLoading
                    ? spinKitLoaderWidget()
                    : customButton('Reset password', _submitButton)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submitButton() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      final response =
          await PostServices.forgortPassword(token, _emailController.text);

      setState(() {
        _isLoading = false;
      });

      if (response is RepoSucess) {
        setState(() {
          _isLoading = false;
        });
        serviceProvider.setPasswordVerifyEmail(_emailController.text);
        flushbarWidget(context, 'Reset token sent successfully', true);
        Navigator.of(context).pushNamed(
          VerifyPasswordResetEmailToken.routeName,
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        flushbarWidget(context, (response as RepoFailure).errorMessage, false);
      }
    }
  }
}
