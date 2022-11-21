// import 'package:flutter/material.dart';
// import 'package:fragvest_mobile/utilities/complete_signup_list_item.dart';
// import 'package:fragvest_mobile/utilities/styles.dart';
// import 'package:fragvest_mobile/widget/random_widget.dart';

// // ignore: must_be_immutable
// class CompleteSignupTabTwo extends StatefulWidget {
//   CompleteSignupTabTwo({
//     Key key,
//   }) : super(key: key);

//   @override
//   _CompleteSignupTabTwoState createState() => _CompleteSignupTabTwoState();
// }

// class _CompleteSignupTabTwoState extends State<CompleteSignupTabTwo> {
//   String _familarity;
//   String _guidance;
//   String _yearlyInvestment;
//   String _duration;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DropdownButtonFormField<String>(
//           value: _familarity,
//           iconSize: 24,
//           icon: arrowDropDown(),
//           hint: dropdownhint('- Investment Familiarity -'),
//           // elevation: 16,
//           style: textfieldStyle,
//           onChanged: (String newValue) {
//             setState(() {
//               _familarity = newValue;
//             });
//           },
//           items: employment.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value, style: textfieldStyle),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           value: _guidance,
//           iconSize: 24,
//           icon: arrowDropDown(),
//           hint: dropdownhint('-- Source of investment guidance -'),
//           style: textfieldStyle,
//           onChanged: (String newValue) {
//             setState(() {
//               _guidance = newValue;
//             });
//           },
//           items: investment.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value, style: textfieldStyle),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 10),
//         DropdownButtonFormField<String>(
//           value: _yearlyInvestment,
//           iconSize: 24,
//           icon: arrowDropDown(),
//           hint: dropdownhint('- Yearly Investment -'),
//           style: textfieldStyle,
//           onChanged: (String newValue) {
//             setState(() {
//               _yearlyInvestment = newValue;
//             });
//           },
//           items: investment.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value, style: textfieldStyle),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 15),
//         DropdownButtonFormField<String>(
//           value: _duration,
//           iconSize: 24,
//           hint: dropdownhint('- Duration of Investment -'),
//           icon: arrowDropDown(),
//           decoration: InputDecoration(
//               counterText: 'How well are you conversant with investing'),
//           style: textfieldStyle,
//           onChanged: (String newValue) {
//             setState(() {
//               _duration = newValue;
//             });
//           },
//           items: investment.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value, style: textfieldStyle),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
