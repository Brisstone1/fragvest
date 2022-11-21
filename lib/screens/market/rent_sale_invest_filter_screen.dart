import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/constants/string_format.dart';
import 'package:fragvest_mobile/model/property_by_type_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/provider/user_token.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/screens/market/rent_sale_invest_detail.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/filter_widget.dart';
import 'package:fragvest_mobile/widget/future_error_message_widget.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/invest_style_widget.dart';
import 'package:fragvest_mobile/widget/rent_style_widget.dart';
import 'package:fragvest_mobile/widget/sale_style_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fragvest_mobile/widget/card_summary.dart';

class RentSaleInvestFilterScreen extends StatefulWidget {
  final String type;
  // static const routeName = '/rsi-screen';
  const RentSaleInvestFilterScreen({Key key, @required this.type})
      : super(key: key);

  @override
  _RentSaleInvestFilterScreenState createState() =>
      _RentSaleInvestFilterScreenState();
}

class _RentSaleInvestFilterScreenState
    extends State<RentSaleInvestFilterScreen> {
  @override
  void initState() {
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    serviceProvider.setRSIType(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final getType = ModalRoute.of(context).settings.arguments as String;
    String token = Provider.of<UserToken>(context, listen: false).userToken;

    ServiceProvider serviceProvider = context.watch<ServiceProvider>();

    return Scaffold(
      appBar: actionAppBar('Property for ${widget.type.toCapitalized()}',
          imgFilter, () => _showFilter(), true, false),
      backgroundColor: kcWhite,
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: GetServices.getPropertyByType(token, widget.type),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return futureErrorMessage(
                      () => setState(() {}),
                      snapshot.error.toString() == 'Division by zero'
                          ? 'Please try again'
                          : snapshot.error.toString());
                } else if (!snapshot.hasData) {
                  return initialLoader(250);
                } else {
                  PropertyByTypeModel propertyByTypeModel = snapshot.data;
                  return GridView.builder(
                    itemCount: propertyByTypeModel.data.length,
                    itemBuilder: (context, index) {
                      final _rsiData = propertyByTypeModel.data[index];
                      final width = MediaQuery.of(context).size.width * 0.41;
                      return GestureDetector(
                        onTap: () {
                          serviceProvider.setRsiData(_rsiData);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  RentSaleInvestDetail(_rsiData)));
                        },
                        child: cardSummary(
                            propertyImages: _rsiData.propertyImages,
                            type: _rsiData.type,
                            propertyType: _rsiData.propertyType,
                            state: _rsiData.state,
                            costPrice: _rsiData.costPrice,
                            invested: _rsiData.fragPrice,
                            width: width,
                            isShopping: true,
                            availableFrag:
                                _rsiData?.propertyStats?.availableFrags),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 4 / 5,
                      mainAxisExtent: 206,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  );
                }
              })),
    );
  }

  _showFilter() {
    showMaterialModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          final serviceProvder =
              Provider.of<ServiceProvider>(context, listen: false);

          serviceProvder.setPriceRange(null);
          serviceProvder.setRooms(null);
          serviceProvder.setBedRoom(null);
          return SortDialog();
          // return SinfleRSIDialogWidget();
        });
  }
}
