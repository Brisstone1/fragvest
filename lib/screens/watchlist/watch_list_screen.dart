import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/watch_list_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/watchlist/watchlist_detail.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/invest_style_widget.dart';
import 'package:fragvest_mobile/widget/rent_style_widget.dart';
import 'package:fragvest_mobile/widget/sale_style_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatefulWidget {
  static const routeName = '/watchlist-screen';

  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  bool _isLoading = false;

  ServiceProvider serviceProvider;

  @override
  void didChangeDependencies() {
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.setAllProerty(true);
    // serviceProvider.setGetProperty(
    //     GetServices.getProperty(context, serviceProvider.allProperty, 'all'));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Watchlist', true),
      body: FutureBuilder<Object>(
          future: GetServices.getWatchList(context),
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
                        setState(() {
                          GetServices.getWatchList(context);
                        });
                      },
                      child: Text(snapshot.error.toString() ==
                              'Connection closed before full header was received'
                          ? 'Internet connection failed'
                          : snapshot.error.toString()),
                    )
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: SpinKitDancingSquare(
                  color: kc3DED97,
                  size: 50,
                ),
              );
            } else {
              WatchListModel watchListModel = snapshot.data;
              return watchListModel.data.length == 0
                  ? Center(
                      child: Text('No property found in your watchlist'),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(20),
                      physics: BouncingScrollPhysics(),
                      itemCount: watchListModel.data.length,
                      itemBuilder: (context, index) {
                        final _watchlistDetail = watchListModel.data[index];

                        return GestureDetector(
                            onTap: () {
                              serviceProvider
                                  .setWatchlistData(_watchlistDetail);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return WatchlistDetail(_watchlistDetail);
                              }));
                            },
                            // child: PropertyTemplateTwo()
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 10),
                                  height: 206,
                                  decoration: BoxDecoration(
                                      // color: Colors.red,
                                      // color: kcWhite.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 0.5,
                                          color: Color(0xFFBDBDBD))),
                                  child: Column(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 120,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(5)),
                                            child: CachedNetworkImage(
                                                imageUrl: _watchlistDetail
                                                    .propertyImages[0],
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.fill)),
                                      ),
                                      if (_watchlistDetail.type == 'sale')
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: SaleStyleWidget(
                                              type: _watchlistDetail.type,
                                              price: _watchlistDetail.costPrice,
                                              tokenId:
                                                  _watchlistDetail.tokenId),
                                        ),
                                      if (_watchlistDetail.type == 'invest')
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: InvestStyleWidget(
                                              type: _watchlistDetail.type,
                                              propertyType:
                                                  _watchlistDetail.propertyType,
                                              state: _watchlistDetail.state,
                                              price: _watchlistDetail.costPrice,
                                              tokenId: _watchlistDetail.tokenId,
                                              rio: _watchlistDetail.roi,
                                            )),
                                      if (_watchlistDetail.type == 'rent')
                                        Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: RentStyleWidget(
                                              type: _watchlistDetail.type,
                                              price: _watchlistDetail.costPrice,
                                              tokenId: _watchlistDetail.tokenId,
                                              propertyTpye:
                                                  _watchlistDetail.propertyType,
                                            ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: kcWhite,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                        'For ${_watchlistDetail.type == "invest" ? "Co-own" : _watchlistDetail.type == "sale" ? "Owned" : _watchlistDetail.type}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF07C168))),
                                  ),
                                ),
                                // _watchList(() {
                                //   _removeWatchList(
                                //       context, _watchlistDetail.id.toInt());
                                // })
                              ],
                            ));
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4 / 5.4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ));
            }
          }),
    );
  }

  Widget _watchList(VoidCallback callback) {
    return Positioned(
      top: 11,
      right: 11,
      child: GestureDetector(
        onTap: callback,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 35,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kcWhite.withOpacity(0.9)),
              child: Image.asset(imgReadHeart)),
        ),
      ),
    );
  }

  _removeWatchList(BuildContext context, int propertyId) async {
    EasyLoading.show(status: 'Just a moment');
    // setState(() => _isLoading = true);
    var response = await PostServices.removeWathlist(context, '$propertyId');

    if (response is LogSucess) {
      setState(() {
        GetServices.getWatchList(context);
      });

      EasyLoading.dismiss();
      flushbarWidget(context, response.message, true);
    } else {
      EasyLoading.dismiss();

      setState(() => _isLoading = false);
      flushbarWidget(context, (response as LogFailure).errorMessage, false);
    }
  }
}
