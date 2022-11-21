import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';

import 'signin_screen.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/change-pwd';
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isNewShow = false;
  bool _isOldShow = false;
  bool _isComfirmShow = false;

  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _comformPasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();

  void _showOldpwd() {
    setState(() {
      _isOldShow = !_isOldShow;
    });
  }

  void _showNewpwd() {
    setState(() {
      _isNewShow = !_isNewShow;
    });
  }

  void _showComfirmPwd() {
    setState(() {
      _isComfirmShow = !_isComfirmShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Change Password', true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: 60),
            Text('Old Password', style: textfieldStyle),
            SizedBox(height: 5),
            SizedBox(
              height: 44,
              child: TextFormField(
                controller: _oldPasswordController,
                obscureText: !_isOldShow,
                decoration: borderTextInputDecoration.copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                        !_isOldShow ? Icons.visibility : Icons.visibility_off),
                    onPressed: _showOldpwd,
                  ),
                ),
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Field required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 35),
            Text('New Password', style: textfieldStyle),
            SizedBox(height: 5),
            SizedBox(
              height: 44,
              child: TextFormField(
                controller: _newpasswordController,
                obscureText: !_isNewShow,
                decoration: borderTextInputDecoration.copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                        !_isNewShow ? Icons.visibility : Icons.visibility_off),
                    onPressed: _showNewpwd,
                  ),
                ),
                validator: (String val) {
                  if (val.isEmpty) {
                    return 'Field required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 35),
            Text('Comfirm New Password', style: textfieldStyle),
            SizedBox(height: 5),
            SizedBox(
              height: 44,
              child: TextFormField(
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
                  if (val != _newpasswordController.text) {
                    return 'Password did not with new password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 65),
            customButton('Change Password', _changePwd)
          ],
        ),
      ),
    );
  }

  _changePwd() async {
    if (_formKey.currentState.validate()) {
      EasyLoading.show(status: 'Just a moment');
      var response = await PostServices.changePassword(
          context,
          _oldPasswordController.text,
          _newpasswordController.text,
          _comformPasswordController.text);

      if (response is LogSucess) {
        EasyLoading.dismiss();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SigninScreen.routeName, (route) => false);
        print(response.message);
      } else {
        EasyLoading.dismiss();

        flushbarWidget(context, (response as LogFailure).errorMessage, false);
      }
    }
  }
}
