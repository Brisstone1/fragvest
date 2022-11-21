import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';

class TourSucessScreen extends StatelessWidget {
  static const routeName = '/tour-success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: MediaQuery.of(context).size.height * 0.2),
            Image.asset(imgModal),
            customButton('Go Back', () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            })
          ],
        ),
      ),
    );
  }
}
