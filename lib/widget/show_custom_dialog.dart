import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

showCustomDialog(
    {BuildContext context,
    String image,
    String title,
    String buttonText,
    Widget massage,
    bool isDismissed,
    @required VoidCallback callback,
    @required VoidCallback clearCalback}) {
  showDialog(
      barrierDismissible: isDismissed ?? true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 320,
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        image,
                        // height: 50,
                      ),
                      SizedBox(height: 20),
                      Text(title, style: st0000000500Rubik14),
                      SizedBox(height: 5),
                      massage,
                      SizedBox(height: 20),
                      MaterialButton(
                        onPressed: callback,
                        child: Text(
                          buttonText,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: kc0C0932,
                      )
                    ],
                  ),
                ),
                Positioned(
                    right: 4,
                    top: 1,
                    child: IconButton(
                        onPressed: clearCalback,
                        icon: Icon(Icons.clear, color: kc0C0932)))
              ],
            ),
          ),
        );
      });
}

paymentDialog(
    {BuildContext context,
    String image,
    String title,
    String buttonText,
    Widget massage,
    @required VoidCallback callback}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    // height: 50,
                  ),
                  SizedBox(height: 25),
                  Text(title, style: st0000000500Rubik14),
                  SizedBox(height: 5),
                  massage,
                  SizedBox(height: 25),
                  MaterialButton(
                    onPressed: callback,
                    child: Text(
                      buttonText,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: kc0C0932,
                  )
                ],
              ),
            ),
          ),
        );
      });
}
