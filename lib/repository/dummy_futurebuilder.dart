import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';

Widget futureBuilderWidget(Future future) {
  return FutureBuilder(builder: (context, snapshot) {
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
        height: 40,
        width: 40,
        child: SpinKitDancingSquare(
          color: kc3DED97,
        ),
      );
    } else {
      return Container();
    }
  });
}
