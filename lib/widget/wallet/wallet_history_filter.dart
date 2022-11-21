import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/utilities/list_item.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/wallet_mv.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';

class WalletHistoryFilter extends StatefulWidget {
  const WalletHistoryFilter({Key key}) : super(key: key);

  @override
  State<WalletHistoryFilter> createState() => _WalletHistoryFilterState();
}

class _WalletHistoryFilterState extends State<WalletHistoryFilter> {
  int currentIndex;
  bool isDate = false;

  @override
  Widget build(BuildContext context) {
    final walletVm = getIt.get<WalletMv>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      height: 400,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                Text('Filter', style: st535353500Rubik),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isDate = false;
                        currentIndex = null;
                      });
                      walletVm.resetFilterData(true);
                    },
                    child: Text(
                      'Reset',
                      style: st000000400Rubik14.copyWith(color: kcEE1A1A),
                    )),
              ],
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transaction type',
                  style: st535353400Rubik15,
                ),
                SizedBox(height: 13),
                Row(
                  children: [
                    typeButton(
                        type: 'Debit',
                        index: 1,
                        callback: () {
                          setState(() {
                            currentIndex = 1;
                            walletVm.setTransactionType('debit');
                          });
                        }),
                    const SizedBox(width: 20),
                    typeButton(
                        type: 'Credit',
                        index: 2,
                        callback: () {
                          setState(() {
                            currentIndex = 2;
                            walletVm.setTransactionType('credit');
                          });
                        }),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Sort by Date',
                  style: st535353400Rubik15,
                ),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: walletVm.selectedDateRange,
                  decoration: borderTextInputDecoration,
                  hint: Text('Select Date'),
                  elevation: 16,
                  isExpanded: true,
                  onChanged: (String value) {
                    setState(() {
                      isDate = true;
                    });
                    if (value == 'Today') {
                      walletVm.setSelectedDate(start: 0, end: 24, value: value);
                    } else if (value == 'Yesterday') {
                      walletVm.setSelectedDate(
                          start: 25, end: 48, value: value);
                    } else if (value == '7 Days Ago') {
                      walletVm.setSelectedDate(
                          start: 0, end: 168, value: value);
                    } else if (value == 'Last Week') {
                      walletVm.setSelectedDate(
                          start: 169, end: 338, value: value);
                    } else if (value == 'Last Month') {
                      walletVm.setSelectedDate(
                          start: 745, end: 1489, value: value);
                    }
                  },
                  items:
                      filterDate.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                customButton('Filter', () {
                  walletVm.getFilter(
                      history: walletVm.walletTransationHistoryModel.history,
                      type: walletVm.transactionType,
                      beginDate: walletVm.startDate,
                      stopDate: walletVm.endDate,
                      isDate: isDate);
                  Navigator.of(context).pop();
                },
                    isActive: !isDate && walletVm.transactionType.isEmpty
                        ? false
                        : true)
              ],
            )
          ],
        ),
      ),
    );
  }

  typeButton({String type, int index, VoidCallback callback}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        height: 36,
        width: 73,
        child: Text(
          type,
          style: stFFFFFF400Rubik14.copyWith(
              color: index == currentIndex ? kcWhite : kcC5C5C5),
        ),
        decoration: BoxDecoration(
            color: index == currentIndex ? kc3DED97 : kcWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: index == currentIndex ? kc3DED97 : kcC5C5C5,
            )),
      ),
    );
  }
}
