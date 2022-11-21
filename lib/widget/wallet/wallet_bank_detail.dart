// import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/user_bank_account_model.dart';
import 'package:fragvest_mobile/screens/wallet/add_new_account.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

import '../../repository/get_services.dart';
import '../../repository/post_services.dart';
import '../../repository/repo_Validatary.dart';
import '../flush_bar_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';import 'package:fragvest_mobile/constants/images_urls.dart';
class WalletBankDetail extends StatefulWidget {
  final UserBankAccountModel userBankAccountModel;
  WalletBankDetail({this.userBankAccountModel});
  @override
  _WalletBankDetailState createState() => _WalletBankDetailState();
}

class _WalletBankDetailState extends State<WalletBankDetail> {
  bool _isBankDetialShowing = false;

  List<Data> bankAccounts = [];

  _showBankDetail() {
    setState(
      () => _isBankDetialShowing = !_isBankDetialShowing,
    );
  }

  @override
  void initState() {
    bankAccounts.addAll(widget.userBankAccountModel.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: _showBankDetail,
          child: Row(
            children: [
              Transform.translate(
                  offset: Offset(-16, 0),
                  child:
                      Text('Bank account details', style: st535353600Rubik16)),
              Spacer(),
              Transform.translate(
                offset: Offset(16, 0),
                child: Icon(!_isBankDetialShowing
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up),
              ),
            ],
          ),
        ),
        if (_isBankDetialShowing)
          widget.userBankAccountModel.data.length == 0
              ? Text('No account detail yet')
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bankAccounts.length,
                  itemBuilder: (context, index) {
                    final bankAccount = bankAccounts[index];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'Access bank'
                                bankAccount.bank.name,
                                style: st535353300Rubik12),
                            const SizedBox(height: 5),
                            Text(
                              // 'Owolabi Muritala O',
                              bankAccount.accountName,
                              style: st535353300Rubik12.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 5),

                            Text(
                              // '05825473745',
                              bankAccount.accountNumber,
                              style: st535353300Rubik12,
                            ),
                          ],
                        ),
                        // Align(
                        //   alignment: Alignment.topCenter,
                        //   child: Text(
                        //     // '05825473745',
                        //     bankAccount.accountNumber,
                        //     style: st535353300Rubik12,
                        //   ),
                        // ),

                        Transform.translate(
                          offset: Offset(0, -10),
                          child: IconButton(
                              onPressed: () {
                                // print('object1');
                                // deleteAccountShowDialog(
                                //     bankAccount.accountNumber, () {
                                //   // print('object');
                                //   _deleteBankAccoun(
                                //       bankAccount.id, bankAccount);
                                //   Navigator.of(context).pop();
                                // });
                                // final serviceProvder =
                                // Provider.of<ServiceProvider>(context, listen: false);
                                // serviceProvder.setPriceRange(null);
                                // serviceProvder.setPropertyType(null);
                                // serviceProvder.setRooms(null);
                                // serviceProvder.setBedRoom(null);
                                showMaterialModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      // return SortByStatus();
                                      return Container(
                                        // color: Colors.blue,
                                        // alignment: Alignment.bottomCenter,
                                        // margin: EdgeInsets.only(top: 100),
                                        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16 ),
                                        height: 222,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                        ),
                                        child: Column(
                                          children: [

                                            Container(
                                                alignment: Alignment.centerLeft,
                                              child: Text('Delete Bank Card', style: TextStyle(
                                                color: Color(0xFF0C0932),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16
                                              ),),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 24, bottom: 40),
                                              child: Text(bankAccount.accountNumber.replaceRange(4, 7, '*******'), style: TextStyle(
                                                color: Color(0xFF535353),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,

                                              ),),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 48,
                                              // height: double.infinity,
                                              child: MaterialButton(
                                                color: Color(0xFFFE4E4E),
                                                onPressed: () {
                                                  _deleteBankAccoun(
                                                      bankAccount.id, bankAccount);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Delete', style: TextStyle(
                                                  color: kcWhite,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                                ),),
                                              ),
                                            ),


                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Transform.translate(
                                offset: Offset(10, 0),
                                child: Image.asset(
                                  imgDelete,
                                  color: Colors.black54,
                                ),
                              )),
                        )
                      ],
                    );
                  }),
        if (_isBankDetialShowing)
          Container(
            alignment: Alignment.centerLeft,
            child: MaterialButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(AddNewAccountScreen.routeName),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: kc3DED97.withOpacity(0.1),
                      child: Icon(Icons.add, color: kc3DED97),
                    ),
                    SizedBox(width: 10),
                    Text('Add new account', style: st535353500Rubik12)
                  ],
                )),
          )
      ],
    );
  }

  _deleteBankAccoun(int id, Data bankAccount) async {
    EasyLoading.show(status: 'Deleting...');
    var response = await PostServices.deleteBankAccount(context, id);
    EasyLoading.dismiss();
    if (response is LogSucess) {
      setState(() {
        bankAccounts.remove(bankAccount);
      });

      await GetServices.getUserAccountBank(context);

      EasyLoading.dismiss();
      flushbarWidget(context, response.message, true);
    } else {
      EasyLoading.dismiss();
      flushbarWidget(context, (response as LogFailure).errorMessage, false);
    }
  }

  deleteAccountShowDialog(String number, VoidCallback callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 197,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(homeIndicator),
                    SizedBox(height: 10,),
                    Text(
                      'Delete Bank Account?',
                      style: st000000400Rubik14.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    Text(
                      number.replaceRange(4, 7, '*******'),
                      style: st000000400Rubik14.copyWith(
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                            color: Colors.red,
                            onPressed: callback,
                            child: Text('Yes', style: stFFFFFF700Rubik18)),
                        MaterialButton(
                            color: kc3DED97,
                            onPressed: () => Navigator.pop(context),
                            child: Text('No', style: stFFFFFF700Rubik18)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
