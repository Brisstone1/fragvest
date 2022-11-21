// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fragvest_mobile/constants/images_urls.dart';
// import 'package:fragvest_mobile/constants/kcolors.dart';
// import 'package:fragvest_mobile/model/get_card_model.dart';
// import 'package:fragvest_mobile/provider/service_provider.dart';
// import 'package:fragvest_mobile/repository/get_services.dart';
// import 'package:fragvest_mobile/repository/post_services.dart';
// import 'package:fragvest_mobile/repository/repo_Validatary.dart';
// import 'package:fragvest_mobile/screens/wallet/pay_via_bank.dart';
// import 'package:fragvest_mobile/utilities/complete_signup_list_item.dart';
// import 'package:fragvest_mobile/utilities/styles.dart';
// import 'package:fragvest_mobile/widget/appbar_widget.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:fragvest_mobile/widget/custom_button_widget.dart';
// import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
// import 'package:fragvest_mobile/widget/text_input_decoration.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// // import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:provider/provider.dart';

// class TopUpComfirmScreen extends StatefulWidget {
//   final String amount;
//   TopUpComfirmScreen(this.amount);
//   static const routeName = '/top-up-comfirm';

//   @override
//   _TopUpComfirmScreenState createState() => _TopUpComfirmScreenState();
// }

// class _TopUpComfirmScreenState extends State<TopUpComfirmScreen> {
//   int _index = 0;

//   int _currentIndex;

//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   bool _inProgress = false;
//   bool _isFromUserCard = true;
//   // bool _isLoading = false;
//   String s = '';
//   String _userCardNumber = '';
//   String _userCvvCode = '';
//   String _userExpireDate = '';
//   String _paymentRef;
//   String _selectedValue;

//   Future<Object> _getCard;

//   // final plugin = PaystackPlugin();

//   // CheckoutMethod _method = CheckoutMethod.card;

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     // plugin.initialize(
//     //     // publicKey: 'pk_test_50b04dbf69ef854255ed467fe512350b6ff1a069'
//     //     publicKey: 'pk_test_a0c20e3ae2dc6615baf9b47414e46cc43c356faf');

//     _getCard = GetServices.getCard(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ServiceProvider serviceProvider = context.watch<ServiceProvider>();
//     return Scaffold(
//       appBar: customAppBar('Add Money to Balance', true),
//       body: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(15.0),
//             height: 45,
//             // width: double.infinity,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: kc535353.withOpacity(0.4))),
//             child: Row(
//               children: [
//                 _toggleButton(
//                   () {
//                     setState(
//                       () => _index = 0,
//                     );
//                   },
//                   'Debit Card',
//                   bgColor: _index == 0 ? kc3DED97 : kcWhite.withOpacity(0.2),
//                   txtColor: _index == 0 ? kcWhite : Color(0xFF000000),
//                 ),
//                 Spacer(),
//                 _toggleButton(
//                   () {
//                     setState(
//                       () => _index = 1,
//                     );
//                   },
//                   'Bank Account',
//                   bgColor: _index == 1 ? kc3DED97 : kcWhite.withOpacity(0.2),
//                   txtColor: _index == 1 ? kcWhite : Color(0xFF000000),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   if (_index == 0)
//                     CreditCardForm(
//                       formKey: formKey,
//                       obscureCvv: false,
//                       obscureNumber: false,
//                       cardNumber: cardNumber,
//                       cvvCode: cvvCode,
//                       isHolderNameVisible: false,
//                       isCardNumberVisible: true,
//                       isExpiryDateVisible: true,
//                       cardHolderName: cardHolderName,
//                       expiryDate: expiryDate,
//                       themeColor: Colors.blue,
//                       textColor: Colors.black,
//                       cardNumberDecoration:
//                           creditCard('Card Number', 'XXXX XXXX XXXX XXXX'),
//                       expiryDateDecoration: creditCard('MM/YY', 'MM/YY'),
//                       cvvCodeDecoration: creditCard('CVV', 'XXX'),
//                       cardHolderDecoration:
//                           creditCard('Card Holder', 'Card Holder'),
//                       onCreditCardModelChange: onCreditCardModelChange,
//                     ),
//                   if (_index == 1)
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Form(
//                           child: Column(
//                         children: [
//                           TextFormField(
//                             decoration:
//                                 creditCard('Account number', 'Account number'),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             padding: const EdgeInsets.only(left: 10),
//                             height: 45,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(color: kcD6D6D6)),
//                             child: DropdownButtonFormField<String>(
//                               value: _selectedValue,
//                               iconSize: 24,
//                               decoration:
//                                   InputDecoration(border: InputBorder.none),
//                               icon: Icon(Icons.arrow_drop_down),
//                               hint: Text('- select bank -',
//                                   style: textfieldStyle),
//                               style: textfieldStyle,
//                               onChanged: (String newValue) {
//                                 setState(() {
//                                   _selectedValue = newValue;
//                                 });
//                               },
//                               items: banks.map<DropdownMenuItem<String>>(
//                                   (String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value, style: textfieldStyle),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       )),
//                     ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _index == 0
//                             ? customButton('Confirm', () {
//                                 if (formKey.currentState.validate()) {
//                                   // _handleCheckout(
//                                   //     context, serviceProvider.email);
//                                 } else {
//                                   print('invalid!');
//                                 }
//                               })
//                             : customButton('Confirm', () => _routeToBankPay()),
//                         const SizedBox(height: 25),
//                         if (_index == 0)
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Use your Saved Card',
//                                   style: st535353700Rubik15),
//                               // Text('No saved card yet', style: st535353300Rubik12),
//                               FutureBuilder<Object>(
//                                   future: _getCard,
//                                   builder: (context, snapshot) {
//                                     if (snapshot.hasError) {
//                                       return Center(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             MaterialButton(
//                                               color: kc3DED97,
//                                               onPressed: () {
//                                                 // setState((){});
//                                               },
//                                               child: Text(
//                                                   snapshot.error.toString()),
//                                             )
//                                           ],
//                                         ),
//                                       );
//                                     } else if (!snapshot.hasData) {
//                                       return SpinKitDancingSquare(
//                                         color: kc3DED97,
//                                         size: 34.0,
//                                       );
//                                     } else {
//                                       GetCardModel getCardModel = snapshot.data;

//                                       return getCardModel.data.length == 0
//                                           ? Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 20.0),
//                                               child: Text('No saved card yet'),
//                                             )
//                                           : ListView.builder(
//                                               shrinkWrap: true,
//                                               itemCount:
//                                                   getCardModel.data.length,
//                                               itemBuilder: (context, index) {
//                                                 final cardDetail =
//                                                     getCardModel.data[index];
//                                                 return Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: GestureDetector(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         _isFromUserCard = false;
//                                                         _currentIndex = index;

//                                                         _userCardNumber =
//                                                             cardDetail
//                                                                 .cardNumber;
//                                                         _userCvvCode =
//                                                             cardDetail.cardCvv;
//                                                         _userExpireDate =
//                                                             cardDetail
//                                                                 .cardExpiryDate;
//                                                       });
//                                                       // _handleCheckout(
//                                                       //     context,
//                                                       //     serviceProvider
//                                                       //         .email);
//                                                       // _comfirmPayment();
//                                                       print(cardDetail
//                                                           .cardExpiryDate);
//                                                     },
//                                                     child: Row(
//                                                       children: [
//                                                         Text(
//                                                             cardDetail
//                                                                 .cardNumber,
//                                                             style: st535353300Rubik12.copyWith(
//                                                                 color: _currentIndex ==
//                                                                         index
//                                                                     ? kc3DED97
//                                                                     : kc535353)),
//                                                         Spacer(),
//                                                         Icon(
//                                                           Icons.check,
//                                                           size: 20,
//                                                           color: _currentIndex ==
//                                                                   index
//                                                               ? kc3DED97
//                                                               : Colors.black
//                                                                   .withOpacity(
//                                                                       0.2),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               });
//                                     }
//                                   }),
//                             ],
//                           )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _toggleButton(VoidCallback callback, String text,
//       {Color bgColor, Color txtColor}) {
//     return GestureDetector(
//       onTap: callback,
//       child: Container(
//         alignment: Alignment.center,
//         height: 45,
//         width: MediaQuery.of(context).size.width * 0.43,
//         decoration: BoxDecoration(
//           // color: kc3DED97,
//           color: bgColor,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(text, style: stNoColor700Rubik15.copyWith(color: txtColor)),
//       ),
//     );
//   }

//   _routeToBankPay() async {
//     EasyLoading.show(status: 'Initailizing...');
//     var response = await PostServices.bankPayment(context, widget.amount);
//     if (response.toString() == 'No internet connection') {
//       EasyLoading.dismiss();
//       return flushbarWidget(context, 'No internet connection', false);
//     } else if (response is RepoSucess) {
//       EasyLoading.dismiss();
//       Navigator.of(context).pushNamed(PayViaBankScreen.routeName);
//     } else {
//       EasyLoading.dismiss();
//       print('jndjndj $response');
//       flushbarWidget(context, (response as LogFailure).errorMessage, false);
//     }
//   }

//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }

//   // _handleCheckout(BuildContext context, String email) async {
//   //   print(email);
//   //   // if (_method != CheckoutMethod.card && _isLocal) {
//   //   //   _showMessage('Select server initialization method at the top');
//   //   //   return;
//   //   // }

//   //   setState(() {
//   //     _paymentRef = 'fragvesPay${DateTime.now().millisecondsSinceEpoch}';
//   //     _inProgress = true;
//   //   });
//   //   Charge charge = Charge()
//   //     ..amount = int.parse('${widget.amount}00') // In base currency
//   //     ..email = email
//   //     ..card = _isFromUserCard ? _getCardFromUI() : _getCardFromUserCard();
//   //   // if (!_isLocal) {
//   //   //   var accessCode = await _fetchAccessCodeFrmServer(_getReference());
//   //   //   charge.accessCode = accessCode;
//   //   // } else {
//   //   //   charge.reference = _getReference();
//   //   // }
//   //   charge.reference = _paymentRef;
//   //   try {
//   //     CheckoutResponse response = await plugin.checkout(context,
//   //         method: CheckoutMethod.card,
//   //         charge: charge,
//   //         fullscreen: false,
//   //         // logo: MyLogo(),
//   //         logo: Image.asset(imgLogo, height: 30));
//   //     print('Response = $response');
//   //     setState(() => _inProgress = false);
//   //     if (response.status) {
//   //       _comfirmPayment();
//   //       // flushbarWidget(context, '${response.message} Transaction', true);

//   //     } else {
//   //       flushbarWidget(context, response.message, false);
//   //     }
//   //     print(response.status);
//   //   } catch (e) {
//   //     setState(() => _inProgress = false);
//   //     _showMessage("Check console for error");
//   //     rethrow;
//   //   }
//   // }

//   _showMessage(String message,
//       [Duration duration = const Duration(seconds: 4)]) {
//     ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
//       content: new Text(message),
//       duration: duration,
//       action: new SnackBarAction(
//           label: 'CLOSE',
//           onPressed: () =>
//               ScaffoldMessenger.of(context).removeCurrentSnackBar()),
//     ));
//   }

//   // String _getReference() {
//   //   return 'fragvesPay${DateTime.now().millisecondsSinceEpoch}';
//   // }

//   // PaymentCard _getCardFromUI() {
//   //   var slipCardDate = expiryDate.split('/');

//   //   return PaymentCard(
//   //     number: cardNumber,
//   //     cvc: cvvCode,
//   //     expiryMonth: int.parse(slipCardDate[0]),
//   //     expiryYear: int.parse(slipCardDate[1]),
//   //   );
//   // }

//   // PaymentCard _getCardFromUserCard() {
//   //   var slipCardDate = _userExpireDate.split('/');
//   //   return PaymentCard(
//   //     number: _userCardNumber,
//   //     cvc: _userCvvCode,
//   //     expiryMonth: int.parse(slipCardDate[0]),
//   //     expiryYear: int.parse(slipCardDate[1]),
//   //   );
//   // }

//   _comfirmPayment() async {
//     EasyLoading.show(status: 'Just a moment');
//     var response = await PostServices.comfirmPayment(
//         context, _paymentRef, int.parse(widget.amount));

//     if (response is LogSucess) {
//       EasyLoading.dismiss();
//       flushbarWidget(
//           context, 'Transaction successful \n ${response.message}', false);
//       // Navigator.of(context).pop();
//     } else {
//       EasyLoading.dismiss();
//       flushbarWidget(context, (response as LogFailure).errorMessage, false);
//     }
//   }
// }
