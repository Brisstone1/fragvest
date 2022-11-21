import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/portfolio_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/portfolio/order_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/portfolio/portfolio_chat.dart';
import 'package:fragvest_mobile/widget/portfolio_widget.dart';
import 'package:provider/provider.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';

class PortFolioScreen extends StatefulWidget {
  const PortFolioScreen({Key key}) : super(key: key);

  @override
  _PortFolioScreenState createState() => _PortFolioScreenState();
}

class _PortFolioScreenState extends State<PortFolioScreen> {
  @override
  Widget build(BuildContext context) {
    String _token = Provider.of<UserToken>(context, listen: false).userToken;
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();

    return Scaffold(
      backgroundColor: kcWhite,
      appBar: AppBar(
        backgroundColor: kcWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Asset Allocation',
          style: stBlack700Rubik18,
        ),
        actions: [
          IconButton(
              icon: Container(
                  alignment: Alignment.centerRight,
                  height: 35,
                  width: 97,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset(imgTimer)

              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(OrderScreen.routeName);
              })
        ],
      ),
      body: FutureBuilder<Object>(
        future: GetServices.getPortfolio(_token, 'all'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: kc3DED97,
                    onPressed: () {
                      // setState((){});
                    },
                    child: Text(snapshot.error.toString()),
                  )
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return Container(
              height: 250,
              alignment: Alignment.center,
              child: SpinKitSpinningLines(
                color: kc3DED97,
              ),
            );
          } else {
            PortfolioModel portfolioModel = snapshot.data;
            serviceProvider.setPortfolioModel(portfolioModel);
            serviceProvider
                .setAssetAllocation(portfolioModel.data.assetAllocation);
            // print('Get the ${portfolioModel.data.assetAllocation.owned}');

            return ListView(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // Text(
                      //   'Asset Allocation',
                      //   style: stFFFFFF700Rubik16.copyWith(color: kc0C0932),
                      // ),
                      // const Spacer(),
                      // GestureDetector(
                      //   onTap: () => Navigator.of(context)
                      //       .pushNamed(OrderScreen.routeName),
                      //   child: Container(
                      //     alignment: Alignment.centerRight,
                      //     height: 35,
                      //     width: 97,
                      //     decoration: BoxDecoration(
                      //         // color: kc3DED97,
                      //         borderRadius: BorderRadius.circular(5)),
                      //     child: Image.asset(imgTimer)
                      //     // Text(
                      //     //   'Order',
                      //     //   style: stFFFFFF400Rubik14,
                      //     // ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Align(alignment: Alignment.topLeft, child: PortFolioChat()),
                SizedBox(height: 36),
                Container(
                  // color: Colors.blue,
                  child: Container(
                    padding: const EdgeInsets.all(14.0),
                    //TODO: Remove the status and replace API status
                    child: PortfolioWidget(scrowable: false, isShowAll: true),
                  ),
                )

              ],
            );
          }
        },
      ),
    );
  }
}
