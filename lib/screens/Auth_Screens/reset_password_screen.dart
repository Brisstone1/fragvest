import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/Auth_Screens/signin_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:provider/provider.dart';

class ResetPassordScreen extends StatefulWidget {
  static const routeName = '/reset-password-screen';

  @override
  _ResetPassordScreenState createState() => _ResetPassordScreenState();
}

class _ResetPassordScreenState extends State<ResetPassordScreen> {
  bool _isShow = false;
  bool _isComfirmShow = false;
  bool _isLoading = false;
  String _token;

  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _comformPasswordController = TextEditingController();

  ServiceProvider serviceProvider;

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
    _token = Provider.of<UserToken>(context, listen: false).userToken;
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Password',
                  style: st535353500Rubik16,
                ),

                const SizedBox(height: 40),
                Text('Email Address', style: textfieldStyle),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: kcD6D6D6)),
                  child: Text(
                    serviceProvider.passwordVerifyEmail,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                Text('New Password', style: textfieldStyle),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: !_isShow,
                  decoration: borderTextInputDecoration.copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                          !_isShow ? Icons.visibility : Icons.visibility_off),
                      onPressed: _showingpwd,
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
                const SizedBox(height: 20),
                Text('Confirm Password', style: textfieldStyle),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _comformPasswordController,
                  obscureText: !_isComfirmShow,
                  decoration: borderTextInputDecoration.copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(!_isComfirmShow
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: _showComfirmPwd,
                    ),
                  ),
                  validator: (String val) {
                    if (val != _newPasswordController.text) {
                      return 'Password do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 43),
                //Reset User password
                _isLoading
                    ? spinKitLoaderWidget()
                    : customButton('Reset', _submitButton),
                const SizedBox(height: 8),
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
      final response = await PostServices.resetPassword(
          _token,
          _newPasswordController.text,
          _comformPasswordController.text,
          serviceProvider.passwordVerifyEmail,
          serviceProvider.passwordResetToken);

      setState(() {
        _isLoading = false;
      });

      if (response is RepoSucess) {
        setState(() {
          _isLoading = false;
        });
        await flushbarWidget(context, 'Reset token sent successfully', true);
        Navigator.of(context).pushNamed(
          SigninScreen.routeName,
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
