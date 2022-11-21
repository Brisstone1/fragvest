import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String orderType;
  final String title;
  const RetryButton(
      {Key key,
      @required this.voidCallback,
      this.orderType,
      @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: voidCallback,
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  color: kcEE1A1A, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Retry',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
