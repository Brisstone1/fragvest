import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/sucess_bottom_modal_sheet.dart';
import '../repository/post_services.dart';
import '../repository/repo_Validatary.dart';
import 'flush_bar_widget.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class SecurityPinWidget extends StatefulWidget {
  final String amount;
  final int id;
  final String operationType;
  SecurityPinWidget({this.amount, this.id, @required this.operationType});
  // static const routeName = '/security-pin';
  @override
  _SecurityPinWidgetState createState() => _SecurityPinWidgetState();
}

class _SecurityPinWidgetState extends State<SecurityPinWidget> {
  // StreamController<ErrorAnimationType> errorController;

  bool _isLoading = false;
  // String _token;

  List<String> _pinCode = [];
  // int _pinLength = 4;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        // height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        // color: Colors.red,
        height: 145,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(

            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                        child: Text('Enter Pin', style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),)

                    ),
                    SizedBox(height: 14,),

                    Container(

                      child:  PinCodeFields(
                        length: 4,
                        fieldBorderStyle: FieldBorderStyle.square,
                        responsive: false,
                        fieldHeight: 52.0,
                        fieldWidth: 52.0,
                        borderWidth: 1.0,
                        activeBorderColor: kc07C168,
                        activeBackgroundColor: kc07C168,
                        borderRadius: BorderRadius.circular(5.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: false,
                        fieldBackgroundColor: Color(0xFFF5F5F8),
                        borderColor: Color(0xFFF5F5F8),
                        textStyle: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                        ),
                        onComplete: (output) {

                          _onCompleteEvent(pin: output);
                        },
                      ),
                    ),
                  ],
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
              ],
            ),
          )
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

  _onCompleteEvent({pin}) async {
    // if (_pinCode.length == 4) {
      EasyLoading.show(status: 'Just a moment...');

      final pVm = getIt.get<PortfolioVm>();

      if (widget.operationType == 'withdraw') {
        var response = await PostServices.withdrawFund(
            context, widget.amount,pin, widget.id);
        EasyLoading.dismiss();
        if (response is LogSucess) {
          showBottmModelSheetCustomNaav(
              context, response.message ?? 'Successful', () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        } else {
          Navigator.of(context).pop();

          flushbarWidget(
              context,
              (response as LogFailure).errorMessage ?? 'Withdrawal failed',
              false);
        }
      } else if (widget.operationType == 'forfeit') {
        Text message =
            Text('Property succefully forfeited', style: st000000400Roboto12);
        pVm.forfeitProperty(context, '${widget.id}', pin, message);
      } else if (widget.operationType == 'sellProperty') {
        Text message =
            Text('Property sold successfully', style: st000000400Roboto12);
        pVm.sellProperty(context, '${pVm.sellPropertyMap.portfolioId}',
            pVm.sellPropertyDiscount, pin, message);
      } else if (widget.operationType == 'sellAsset') {
        Text message =
            Text('Your sell order was successful', style: st000000400Roboto12);
        pVm.sellFrag(
            context: context,
            portfolioId: '${pVm.sellPropertyMap.portfolioId}',
            frag:
                '${double.tryParse(pVm.sellPropertyMap.pressedValue).toStringAsFixed(0)}',
            pin: pin,
            message: message);
      } else if (widget.operationType == 'renewRent') {
        Text message = Text(
            'You have successfully renewed your rent on this property',
            style: st000000400Roboto12);
        pVm.renewRent(
            context: context,
            propertyId: '${pVm.sellPropertyMap.portfolioId}',
            duration: pVm.sellPropertyMap.renewDuration,
            pin: pin,
            message: message);
      }
    }
  // }
}
