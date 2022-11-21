import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class FewPropertyDetailWidget extends StatefulWidget {
  final List<String> propertyFeature;
  FewPropertyDetailWidget(this.propertyFeature);

  @override
  _FewPropertyDetailWidgetState createState() =>
      _FewPropertyDetailWidgetState();
}

class _FewPropertyDetailWidgetState extends State<FewPropertyDetailWidget> {
  bool _isPropertyShowing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          onPressed: () =>
              setState(() => _isPropertyShowing = !_isPropertyShowing),
          child: Row(
            children: [
              Text('Property Detail', style: st0C0932700Rubik12),
              Spacer(),
              Icon(!_isPropertyShowing
                  ? Icons.arrow_drop_down
                  : Icons.arrow_drop_up),

              // if (_isPropertyShowing)
              //   GestureDetector(
              //     onTap: () {
              //       ///TOTDO::: Route here
              //     },
              //     child: Row(
              //       children: [
              //         Text('View full details',
              //             style: stFFC327400Rubik12.copyWith(color: kc0C0932)),
              //         Icon(
              //           Icons.east,
              //           size: 20,
              //           color: kc0C0932,
              //         )
              //       ],
              //     ),
              //   ),
            ],
          ),
        ),
        if (_isPropertyShowing)
          Wrap(
            spacing: 8.0,
            runSpacing: 10.0,
            children: widget.propertyFeature
                .map((e) => Container(
                    height: 32,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xFF07C168), width: 0.4),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Color(0xFF07C168),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    )))
                .toList(),
          ),
      ],
    );
  }
}
