import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/support/tickets_screen.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
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
// '''
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/dashboard_model.dart';
import 'package:fragvest_mobile/model/fee_model.dart';
import 'package:fragvest_mobile/model/get_blog_post_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/dashboard/all_portfolio_screen.dart';
import 'package:fragvest_mobile/screens/dashboard/all_trending_screen.dart';
// kkk
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

class CreateTicket extends StatefulWidget {
  static const routeName = '/creat-ticket';
  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar('Create a Ticket', true),
        body: RefreshIndicator(
            onRefresh: _refreshScreen,
            displacement: 100,
            color: kc00AA57,
            child: SingleChildScrollView(
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
                        return initialLoader(
                            MediaQuery.of(context).size.height);
                      } else {
                        DashboardModel dashbordModel = snapshot.data[0];
                        GetBlogPostModel getBlogPostModel = snapshot.data[1];
                        FeeModel feeModel = snapshot.data[2];
                        final _data = dashbordModel.data;

                        //Set values to provider
                        // serviceProvider.setDataDashboard(_data);
                        // serviceProvider.setTrending(_data.trending.properties);
                        // serviceProvider.setPortfolio(_data.portfolio);
                        // serviceProvider.setLatest(_data.latest.properties);
                        // // serviceProvider.setPosts(_data.posts);
                        // serviceProvider.setFeeModel(feeModel);

                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text('Full Name', style: textfieldStyle),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: _subjectController..text = "${_data.user.firstName.replaceFirst(_data.user.firstName[0], _data.user.firstName[0].toUpperCase())} ${_data.user.lastName.replaceFirst(_data.user.lastName[0], _data.user.lastName[0].toUpperCase())}",
                                  // decoration: supportDecoration,
                                  // initialValue:"ll",
                                  decoration: InputDecoration(
                                    hintText: "Full Name",
                                    filled: true,
                                    fillColor: Color(0xFFF5F5F8),
                                    hintStyle:
                                    TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                                      borderRadius: BorderRadius.circular(5.0),
                                      //<-- SEE HERE
                                    ),
                                  ),

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'What is the issue?';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 40),
                                Text(
                                  'Comments',
                                  style: textfieldStyle,
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    hintText: "example@gmail.com",
                                    filled: true,
                                    fillColor: Color(0xFFF5F5F8),
                                    hintStyle:
                                    TextStyle(fontSize: 12.0, color: Color(0xFF969595)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 5, color: Color(0xFFF5F5F8)),
                                      borderRadius: BorderRadius.circular(5.0),
                                      //<-- SEE HERE
                                    ),
                                  ),
                                  controller: _descriptionController,
                                  // decoration: supportDecoration,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'What to know the issue';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 60),
                                customButton('Submit', _createTicket)
                              ],
                            ),
                          ),
                        );

                      }
                    }))));
  }

  _createTicket() async {
    // Navigator.of(context).pushNamed(TicketScreen.routeName, arguments: true);
    if (_formKey.currentState.validate()) {
      EasyLoading.show();
      final response = await PostServices.createTicket(
          context, _subjectController.text, _descriptionController.text);

      if (response is RepoSucess) {
        EasyLoading.dismiss();
        Navigator.of(context)
            .pushNamed(TicketScreen.routeName, arguments: true);
      } else {
        EasyLoading.dismiss();
        flushbarWidget(context, (response as RepoFailure).errorMessage, false);
      }
    }
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
}



// Future<void> _refreshScreen() {
//   return Future.delayed(Duration(seconds: 8), () async {
//     await GetServices.getWalletBalance(context);
//     await GetServices.getUserAccountBank(context);
//     await GetServices.getCard(context);
//     setState(() {});
//     // await GetServices.getWalletHistory(context);
//   });
// }