import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/dashboard_model.dart';
import 'package:fragvest_mobile/model/fee_model.dart';
import 'package:fragvest_mobile/model/get_blog_post_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/dashboard/all_portfolio_screen.dart';
import 'package:fragvest_mobile/screens/dashboard/all_trending_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/dommy_avater_widget.dart';
import 'package:fragvest_mobile/widget/future_error_message_widget.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/dashboard/new_feed_propert_widget.dart';
import 'package:fragvest_mobile/widget/portfolio_property_widget.dart';
import 'package:fragvest_mobile/widget/trending_property_widget.dart';
import 'package:fragvest_mobile/widget/wallet/wallet_balance.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DashbordScreen extends StatefulWidget {
  const DashbordScreen({Key key}) : super(key: key);

  @override
  _DashbordScreenState createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider = context.watch<ServiceProvider>();
    return Scaffold(
      backgroundColor: kcWhite,
      appBar: AppBar(
        backgroundColor: kcWhite.withOpacity(0.2),
        elevation: 0.0,
        toolbarHeight: 20,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshScreen,
        displacement: 100,
        color: kc00AA57,
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: BouncingScrollPhysics(),
            child: FutureBuilder<List>(
                future: Future.wait([
                  GetServices.getDashbord(context),
                  GetServices.getBlogPost(context),
                  GetServices.getFee(context)
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return futureErrorMessage(
                        () => setState(() {}),
                        snapshot.error.toString() == 'Division by zero'
                            ? 'Please try again'
                            : snapshot.error.toString());
                  } else if (!snapshot.hasData) {
                    return initialLoader(MediaQuery.of(context).size.height);
                  } else {
                    DashboardModel dashbordModel = snapshot.data[0];
                    GetBlogPostModel getBlogPostModel = snapshot.data[1];
                    FeeModel feeModel = snapshot.data[2];
                    final _data = dashbordModel.data;

                    //Set values to provider
                    serviceProvider.setDataDashboard(_data);
                    serviceProvider.setTrending(_data.trending.properties);
                    serviceProvider.setPortfolio(_data.portfolio);
                    serviceProvider.setLatest(_data.latest.properties);
                    // serviceProvider.setPosts(_data.posts);
                    serviceProvider.setFeeModel(feeModel);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            profileImage(_data.user.profileImg),
                            SizedBox(width: 20),
                            Text(
                                _data.user.firstName == 'null' ||
                                        _data.user.firstName == null
                                    ? 'Welcome User'
                                    : 'Welcome, ${_data.user.firstName.replaceFirst(_data.user.firstName[0], _data.user.firstName[0].toUpperCase())}',
                                style: stBlue600Rubik18),
                          ],
                        ),
                        SizedBox(height: 15),
                        WalletBalance(),
                        SizedBox(height: 40),
                        _title('Newest Deals', () {
                          Navigator.of(context)
                              .pushNamed(AllTrendingScreen.routeName);
                        }),
                        Container(
                            // height: 215,
                            height: _data.portfolio.length == 0 ? 200 :220,
                            // width: 165,
                            child: TrendingPropertyWidget(
                              isAll: false,
                              scrowable: false,
                            )
                        ),
                        SizedBox(height: 40),
                        _portfolioTiel(_data.portfolio.length),
                        Container(
                            height: _data.portfolio.length == 0 ? 200 :220,
                            child: PortfolioPropertyWidget(
                                isAll: false, scrowable: false)
                        ),
                        SizedBox(height: 40),
                        _title('News Feed',
                            () => _launchURL('https://blog.fragvest.com/')),
                        SizedBox(height: 5),
                        Container(
                            height: 230,
                            child: NewFeedPropertyWidget(
                              getBlogPostModel: getBlogPostModel,
                            )),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No more cards to show',
                            style: st2F54C6400Rubik11.copyWith(color: kc535353),
                          ),
                        ),
                        SizedBox(height: 70)
                      ],
                    );
                  }
                })),
      ),
    );
  }

  Future<void> _refreshScreen() {
    ServiceProvider serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);

    return Future.delayed(Duration(seconds: 8), () {
      FutureBuilder(
          future: GetServices.getDashbord(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return futureErrorMessage(
                  () => setState(() {}), snapshot.error.toString());
            } else if (!snapshot.hasData) {
              return null;
            } else {
              DashboardModel dashbordModel = snapshot.data;
              setState(() {});
              return serviceProvider.setDataDashboard(dashbordModel.data);
            }
          });
    });
  }

  Widget _title(String text, VoidCallback callback) {
    return Row(
      children: [
        Text(text, style: st535353600Rubik16),
        Spacer(),
        MaterialButton(
            child: Transform.translate(
                offset: Offset(16, 0),
                child: Text('View all',
                    style: st0C0932700Rubik11.copyWith(
                        // decoration: TextDecoration.underline,
                        decorationThickness: 2))),
            onPressed: callback)
      ],
    );
  }

  Widget _portfolioTiel(int lenght) {
    return Row(
      children: [
        Text('Portfolio', style: st535353600Rubik16),
        Spacer(),
        lenght == 0
            ? SizedBox()
            : MaterialButton(
                child: Transform.translate(
                    offset: Offset(16, 0),
                    child: Text('View all',
                        style: st0C0932700Rubik11.copyWith(
                            // decoration: TextDecoration.underline,
                            decorationThickness: 2))),
                onPressed: () {
                  Navigator.of(context).pushNamed(AllPortfolioScreen.routeName);
                })
      ],
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
