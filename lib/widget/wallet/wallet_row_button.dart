import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/screens/wallet/add_new_card.dart';
import 'package:fragvest_mobile/screens/wallet/top_up_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class WalletRowButton extends StatefulWidget {
  @override
  _WalletRowButtonState createState() => _WalletRowButtonState();
}

class _WalletRowButtonState extends State<WalletRowButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  _containerButton('Add card',
              () => Navigator.of(context).pushNamed(AddNewCarScreen.routeName)),
    );
  }

  Widget _containerButton(String text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kc3DED97,
          borderRadius: BorderRadius.all(Radius.circular(5))
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(imgPaperPlus, height: 20),
            SizedBox(width: 15),
            Text(text, style: TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w500
            ))
          ],
        ),
      ),
    );
  }
}












