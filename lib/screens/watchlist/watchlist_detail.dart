import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/watch_list_model.dart' as watch;
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/random_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/other_watchlist_detail.dart';

class WatchlistDetail extends StatefulWidget {
  final watch.Data watchlistDetail;
  const WatchlistDetail(this.watchlistDetail, {Key key}) : super(key: key);

  @override
  State<WatchlistDetail> createState() => _WatchlistDetailState();
}

class _WatchlistDetailState extends State<WatchlistDetail> {
  bool _isfavourite = false;
  bool _isLoading = false;
  String _showImageUrl;

  @override
  void initState() {
    _showImageUrl = widget.watchlistDetail.propertyImages[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: _showImageUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Container(
                        child: SpinKitPianoWave(
                      color: kc3DED97,
                    )),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: kcWhite,
                          borderRadius:
                          BorderRadius.circular(2)),
                      child: Text('Fragvest ID: ${widget.watchlistDetail.tokenId}',
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF07C168))),
                    ),
                  ),
                  if (widget.watchlistDetail.type == 'invest')
                    _displayPostion('Invest', kc2F54C6),
                  if (widget.watchlistDetail.type == 'invest')
                    displayRightPostion(
                        '${widget.watchlistDetail.roi}% p.a', kcWhite),
                  if (widget.watchlistDetail.type == 'rent' &&
                      widget.watchlistDetail.negotiable == 1)
                    _displayPostion('Non-Negotiable', kcEE1A1A)
                ],
              ),
            ),
            title: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kcWhite),
                child: Icon(
                  Icons.arrow_back,
                  color: kc535353,
                  size: 20,
                ),
              ),
            ),
            centerTitle: false,
            // actions: [
            //   _isInWatchlist(
            //       widget.watchlistDetail.inWatchlist, widget.watchlistDetail.id)
            // ],
          ),
          _allBuildinWidget(widget.watchlistDetail.propertyImages),
          // OtherPropertyDetails(),
          OtherWatlistDetails()
        ],
      ),
    );
  }

  // dynamic _isInWatchlist(int inWatchList, int portforlioId) {
  //   if (inWatchList == 1) {
  //     return _checkWatchList(imgReadHeart, callback: () {
  //       flushbarWidget(
  //           context, 'Property already added to your watchlist', false);
  //     });
  //   } else {
  //     if (_isfavourite) {
  //       return _checkWatchList(imgReadHeart);
  //     } else {
  //       return _checkWatchList(imgBlackHeart,
  //           callback: () => _addToWatchList(portforlioId));
  //     }
  //   }
  // }

  // _checkWatchList(String imageUrl, {VoidCallback callback}) {
  //   return _isLoading
  //       ? SpinKitCircle(size: 30, color: kc3DED97)
  //       : GestureDetector(
  //           onTap: callback,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Container(
  //                 padding: const EdgeInsets.all(6),
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: kcWhite.withOpacity(0.7)),
  //                 child: Image.asset(imageUrl)),
  //           ),
  //         );
  // }

  Widget _displayPostion(String text, Color color) {
    return Positioned(
      bottom: 30,
      left: 20,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
        child: Text(text, style: st2F54C6400Rubik11.copyWith(color: kcWhite)),
      ),
    );
  }

  // _addToWatchList(int propertyId) async {
  //   setState(() => _isLoading = true);
  //   var response = await PostServices.addWatchlist(context, '$propertyId');

  //   if (response is LogSucess) {
  //     setState(() {
  //       _isLoading = false;

  //       _isfavourite = true;
  //     });
  //     flushbarWidget(context, response.message, false);
  //   } else {
  //     setState(() => _isLoading = false);
  //     flushbarWidget(context, (response as LogFailure).errorMessage, false);
  //   }
  // }

  Widget _allBuildinWidget(List<String> propertyImages) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: propertyImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _showImageUrl = propertyImages[index]),
                    child: Container(
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: propertyImages[index],
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(
                              child: SpinKitPianoWave(
                            color: kc3DED97,
                            size: 20.0,
                          )),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error)),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
