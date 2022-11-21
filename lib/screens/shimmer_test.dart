import 'package:flutter/material.dart';
import 'package:fragvest_mobile/widget/dommy_avater_widget.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Shimmer.fromColors(
          child: Row(
            children: [dummyAvater(), Text('  ||||||||||||')],
          ),
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
        ),
      ),
    );
  }
}
