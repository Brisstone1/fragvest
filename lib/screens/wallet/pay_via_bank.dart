import 'package:flutter/material.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/kcolors.dart';

class PayViaBankScreen extends StatefulWidget {
  static const routeName = '/pay-via-bank';
  const PayViaBankScreen({Key key}) : super(key: key);

  @override
  State<PayViaBankScreen> createState() => _PayViaBankScreenState();
}

class _PayViaBankScreenState extends State<PayViaBankScreen> {
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kcF5f5f5.withOpacity(0.2),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: kcWhite, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Add Money to Balance', style: stBlack700Rubik18),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: serviceProvider.authorizationUrl,
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'Flutter;Webview',
        // onPageFinished: (nav) {
        //   print('object2');
        // },
        onProgress: (int val) {
          // print('jjhiuh' + val.toString());
        },
        onWebViewCreated: (onWebViewCreated) {
          // print('onweb');
          // onWebViewCreated.loadUrl(url)
        },
        onPageFinished: (val) {
          print('jdjnd ' + val);
        },
        onPageStarted: (val) {
          print('kdjfndjn ' + val);
        },
        navigationDelegate: (navigation) {
          print('Get Url one' + navigation.url);
          // if (navigation.url == 'https://standard.paystack.co/close') {
          //   Navigator.of(context).pop(); //close webview
          //   print('object3');
          // }
          if (navigation.url == "https://fragvest.com") {
            print('Get url 2' + navigation.url);
            print('object');
            Navigator.of(context).pop(); //close webview
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
