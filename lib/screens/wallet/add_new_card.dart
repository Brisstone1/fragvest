import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/splinkit_loader_widget.dart';
import 'package:fragvest_mobile/widget/sucess_bottom_modal_sheet.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:provider/provider.dart';

class AddNewCarScreen extends StatefulWidget {
  static const routeName = '/add-new-card';
  @override
  _AddNewCarScreenState createState() => _AddNewCarScreenState();
}

class _AddNewCarScreenState extends State<AddNewCarScreen> {
  bool _isLoading = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;

  bool _isHolderEmpty = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _token;
  @override
  void initState() {
    _token = Provider.of<UserToken>(context, listen: false).userToken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('New Card', true),
      body: Column(
        children: <Widget>[
          // const SizedBox(
          //   height: 30,
          // ),
          // CreditCardWidget(
          //   // glassmorphismConfig: Glassmorphism.defaultConfig(),
          //   cardNumber: cardNumber,
          //   expiryDate: expiryDate,
          //   cardHolderName: cardHolderName,
          //   cvvCode: cvvCode,
          //   showBackView: isCvvFocused,
          //   obscureCardNumber: true,
          //   obscureCardCvv: true,
          //   isHolderNameVisible: true,
          //   cardBgColor: kc0C0932,
          //
          //   // backgroundImage: imgCredit,
          //   isSwipeGestureEnabled: true,
          //   onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
          //   customCardTypeIcons: <CustomCardTypeIcon>[
          //     CustomCardTypeIcon(
          //       cardType: CardType.mastercard,
          //       cardImage: Image.asset(
          //         imgMasterCard,
          //         height: 48,
          //         width: 48,
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: false,
                    obscureNumber: false,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    cardHolderName: cardHolderName,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,

                    expiryDate: expiryDate,
                    themeColor: Colors.blue,
                    textColor: Colors.black,
                    cardNumberDecoration:
                        creditCard('Card number', 'XXXX XXXX XXXX XXXX'),
                    expiryDateDecoration: creditCard('Expiry Date', 'MM/YY'),
                    cvvCodeDecoration: creditCard('CVV', 'XXX'),
                    cardHolderDecoration:
                        creditCard('Card Holder Name', 'Card Holder Name'),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _isHolderEmpty ? 'Please input card holder name' : '',
                          style:
                              TextStyle(color: Color(0xFFD33030), fontSize: 13),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _isLoading
                        ? spinKitLoaderWidget()
                        : customButton('Add card', () {
                            if (formKey.currentState.validate()) {
                              if (cvvCode.length == 3) {
                                if (cardHolderName.isEmpty) {
                                  setState(() {
                                    _isHolderEmpty = true;
                                  });
                                  print('Enter card holder name');
                                } else {
                                  setState(() {
                                    _isHolderEmpty = false;
                                  });
                                }
                                print(cardHolderName);
                                _submitCard();
                              } else {
                                flushbarWidget(context,
                                    'Card CVV must be 3 numbers', false);
                              }
                            } else {
                              print('invalid!');
                            }
                          }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber.replaceAll(' ', '');
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  _submitCard() async {
    // print(cardNumber.trim());
    setState(() => _isLoading = true);
    var response = await PostServices.addNewCard(
        _token, int.parse(cardNumber.trim()), cvvCode, expiryDate);

    if (response is LogSucess) {
      setState(() => _isLoading = false);
      // flushbarWidget(context, response.message, true);
      showBottmModelShweet(context, response.message);
    } else {
      setState(() => _isLoading = false);
      flushbarWidget(context, (response as LogFailure).errorMessage, false);
    }
  }
}
