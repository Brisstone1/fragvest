import 'package:flutter/material.dart';
import 'package:fragvest_mobile/model/onboard_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplanationPage extends StatelessWidget {
  ExplanationPage({Key key, this.model, this.list}) : super(key: key);
  final OnBoardModel model;
  final List<OnBoardModel> list;
  String hexString = "07C168";

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.all(0),
          alignment: Alignment.center,
          // color: Colors.green,
          // color: Color(int.parse('FF07C168', radix: 16)),
          color: Color(int.parse("0xff${hexString}")),
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.5,
          //
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: Colors.green[200],
                // margin: const EdgeInsets.only(top: 24, bottom: 16),
                height: 200,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset(
                  model.images,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
        Center(
            child: Container(
          padding: EdgeInsets.only(top: 24),
          child: Text(
            model.title,
            style: TextStyle(
                color: Color(0xFF003C58),
                fontSize: 22,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        )),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Padding(
              padding: EdgeInsets.only(top: 18),
              child: Text(
                model.description,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF969595)),
                textAlign: TextAlign.center,
              ),
            )),
      ],
    );
  }
}
