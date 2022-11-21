// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fragvest_mobile/constants/kcolors.dart';
// import 'package:fragvest_mobile/screens/verification_screen.dart';
// import 'package:fragvest_mobile/screens/wallet/security_pin_screen.dart';
// import 'package:fragvest_mobile/utilities/styles.dart';
// import 'package:fragvest_mobile/widget/random_widget.dart';

// class AccountSettinWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       color: kc0C0932,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 50),
//           Text('Account Settings', style: stFFFFFF700Rubik16),
//           const SizedBox(height: 10),
//           boxContainerWithoutEdit('Change  Password', 'Tap to update password',
//               Icons.lock_outline, kcWhite.withOpacity(0.8), () {}),
//           boxContainerWithoutEdit(
//               'Verify your account',
//               '(This will help you sell properties on our platform)',
//               Icons.check_box_outlined,
//               kcWhite.withOpacity(0.8), () {
//             Navigator.of(context).pushNamed(VerificationScreen.routeName);
//           }),
//           boxContainerWithoutEdit('Security Pin', '******', Icons.security,
//               kcWhite.withOpacity(0.8), () {
//             Navigator.of(context).pushNamed(SecurityPinScreen.routeName);
//           })
//         ],
//       ),
//     );
//   }
// }
