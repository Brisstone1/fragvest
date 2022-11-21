import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/paystack_bank_list.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/wallet/wallet_home.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/future_error_message_widget.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';

import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:provider/provider.dart';

class AddNewAccountScreen extends StatefulWidget {
  static const routeName = '/add-new-account-screen';

  @override
  _AddNewAccountScreenState createState() => _AddNewAccountScreenState();
}

class _AddNewAccountScreenState extends State<AddNewAccountScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String _selectedValue;
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  String token;

  @override
  void initState() {
    token = Provider.of<UserToken>(context, listen: false).userToken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('New Account', true),
      body: FutureBuilder(
          future: GetServices.paystackBankList(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return futureErrorMessage(() {}, snapshot.error.toString());
            } else if (!snapshot.hasData) {
              return initialLoader(MediaQuery.of(context).size.height);
            } else {
              PaystackBankListModel paystackBankListModel = snapshot.data;
              // GetBanksModel getBanksModel = snapshot.data;
              // final _banks = getBanksModel.data;
              final _banks = paystackBankListModel.data;
              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Account Name",
                        style: TextStyle(
                            color: Color(0xFF969595),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      height: 44,
                      child: TextFormField(
                        controller: _accountNameController,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'Account name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Account name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Account Number",
                        style: TextStyle(
                            color: Color(0xFF969595),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                        height: 44,
                        child: TextFormField(
                          controller: _accountNumberController,
                          decoration: borderTextInputDecoration.copyWith(
                              hintText: 'Account number'),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Account number is required';
                            }
                            return null;
                          },
                        )),
                    const SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Select Bank",
                        style: TextStyle(
                            color: Color(0xFF0C0932),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                        // padding: const EdgeInsets.only(left: 10),
                        height: 44,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xFFF5F5F8))),
                        child: DropdownButtonFormField<String>(
                            value: _selectedValue,
                            iconSize: 24,
                            decoration: InputDecoration(
                              filled: true, //<-- SEE HERE
                              fillColor: Color(0xFFF5F5F8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 5, color: Color(0xFFF5F5F8)),
                                borderRadius: BorderRadius.circular(5.0),
                                //<-- SEE HERE
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0))),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            // hint: d'Select Annual income'),
                            icon: Icon(Icons.arrow_drop_down),
                            hint: Text('select Bank', style: textfieldStyle),
                            style: textfieldStyle,
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedValue = newValue;
                              });
                            },
                            items: _banks.map((map) {
                              return DropdownMenuItem(
                                child: Text(map.name),
                                value: '${map.id}',
                              );
                            }).toList())),
                    SizedBox(height: 30),
                    // Text('OWOLABI MURITALA O', style: st535353700Rubik15)
                  ],
                ),
              );
            }
          }),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoading
            ? spinKitLoaderWidget()
            : customButton('Add Account', _adduserAccount),
      ),
    );
  }

  _adduserAccount() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);

      var response = await PostServices.addBank(token, _selectedValue,
          _accountNameController.text, _accountNumberController.text);

      print(response);
      if (response is LogSucess) {
        setState(() => _isLoading = false);
        flushbarWidget(context, response.message, true);
        setState(() {});
        Navigator.of(context).pushNamed(WalletHome.routeName);
        // Navigator.pop(context);

       // Navigator.of(context)
       //      .pushNamed(WalletHome.routeName);
       //  Navigator.push(
       //      context,
       //      MaterialPageRoute(builder: (context) => WalletHome()),
       //  Navigator.push(
       //      context,
       //      MaterialPageRoute(builder: (context) => WalletHome());


      } else {
        setState(() => _isLoading = false);
        flushbarWidget(context, (response as LogFailure).errorMessage, false);
      }
    }
  }
}
