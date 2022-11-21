// import 'package:flutter/material.dart';
// import 'package:fragvest_mobile/utilities/complete_signup_list_item.dart';
// import 'package:fragvest_mobile/utilities/styles.dart';
// import 'package:fragvest_mobile/widget/random_widget.dart';

// // ignore: must_be_immutable
// class CompleteSignupTabOne extends StatefulWidget {
//   String personalInfo;
//   String familarity;
//   String sourceOfInvest;
//   String yearlyInvest;
//   String duration;
//   CompleteSignupTabOne(
//       {Key key,
//       this.personalInfo,
//       this.familarity,
//       this.sourceOfInvest,
//       this.yearlyInvest,
//       this.duration})
//       : super(key: key);

//   @override
//   _CompleteSignupTabOneState createState() => _CompleteSignupTabOneState();
// }

// class _CompleteSignupTabOneState extends State<CompleteSignupTabOne> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       child: Column(
//         children: [
//           DropdownButtonFormField<String>(
//             value: widget.personalInfo,
//             iconSize: 24,
//             icon: arrowDropDown(),
//             hint: dropdownhint('- Select Employment Status -'),
//             // elevation: 16,
//             style: textfieldStyle,
//             onChanged: (String newValue) {
//               setState(() {
//                 widget.personalInfo = newValue;
//               });
//             },
//             items: employment.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value, style: textfieldStyle),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 10),
//           DropdownButtonFormField<String>(
//             value: widget.familarity,
//             iconSize: 24,
//             icon: arrowDropDown(),
//             hint: dropdownhint('- Select Annual income -'),
//             style: textfieldStyle,
//             onChanged: (String newValue) {
//               setState(() {
//                 widget.familarity = newValue;
//               });
//             },
//             items: investment.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value, style: textfieldStyle),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 10),
//           DropdownButtonFormField<String>(
//             value: widget.sourceOfInvest,
//             iconSize: 24,
//             icon: arrowDropDown(),
//             hint: dropdownhint('- Source of investment guidance -'),
//             style: textfieldStyle,
//             onChanged: (String newValue) {
//               setState(() {
//                 widget.sourceOfInvest = newValue;
//               });
//             },
//             items: investment.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value, style: textfieldStyle),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
