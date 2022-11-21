import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/countries.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      loadSplashScreen();
    });
    super.initState();
  }

  loadSplashScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CountryList();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0C0932),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/tick-square.png'),
              CupertinoActivityIndicator(),
              Text('Fragvest',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w700))
            ],
          ),
        ));
  }
}
