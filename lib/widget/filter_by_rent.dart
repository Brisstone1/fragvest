import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/constants/string_format.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/portfolio_wm.dart';
import 'package:fragvest_mobile/widget/initial_loader_widget.dart';
import 'package:fragvest_mobile/widget/retry_button.dart';

// class filterByRentTab extends StatelessWidget {
//
//   const filterByRentTab({Key key}): super(key: key)
//
//   @override
//   Widget build(BuildContext context){
//     // return BaseViewBuilder( model: getIt(),
//     //     initState: (init) {
//     //       init.getRentOrder();
//     //     },
//     // )
//   }
//
// }

class filterByRentTab extends StatelessWidget {
  const filterByRentTab({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<PortfolioVm>(
        model: getIt(),
        initState: (init) {
          init.getRentOrder();
        },
        builder: (pVm, child) {
          return Container(
            child: Text(
              'Is GOld MAn'
            )
          );
        });
  }
}
