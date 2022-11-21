import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';

Widget dummyAvater() {
  return CircleAvatar(
    radius: 20,
    backgroundColor: kcD1D1D1,
    child: Image.asset(
      imgAvater,
      height: 28,
    ),
  );
}

Widget profileImage(String image) {
  return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(color: kcD1D1D1, shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.network(
          image,
          fit: BoxFit.fill,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return Center(child: dummyAvater());
          },
        ),
      ));
}

// Widget profileImage1(String image) {
//   print('*** $image');
//   return CircleAvatar(
//       radius: 20,
//       backgroundColor: kcD1D1D1,
//       child: Image.network(
//         image,
//         errorBuilder:
//             (BuildContext context, Object exception, StackTrace stackTrace) {
//           return Center(child: dummyAvater());
//         },
//       ));
// }
