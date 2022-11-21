import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/transaction_history_model.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

class AllTransactionHistoryWidget extends StatefulWidget {
  final String duration;
  AllTransactionHistoryWidget(this.duration);
  @override
  State<AllTransactionHistoryWidget> createState() =>
      _AllTransactionHistoryWidgetState();
}

class _AllTransactionHistoryWidgetState
    extends State<AllTransactionHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    // String _token = Provider.of<UserToken>(context, listen: false).userToken;

    return FutureBuilder<Object>(
        future: GetServices.getPropertyHistory(context, widget.duration),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: kc3DED97,
                    onPressed: () {
                      setState(() {
                        GetServices.getPropertyHistory(
                            context, widget.duration);
                      });
                    },
                    child: Text(snapshot.error.toString() ==
                            'Connection closed before full header was received'
                        ? 'Internet connection failed'
                        : snapshot.error.toString()),
                  )
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return Container(
              height: 40,
              // width: 40,
              child: SpinKitDancingSquare(
                color: kc3DED97,
              ),
            );
          } else {
            TransactionHistoryModel txnHistory = snapshot.data;
            return txnHistory.data.length == 0
                ? Container(
                    alignment: Alignment.center,
                    height: 250,
                    child: Text(
                        'No transaction history for the ${widget.duration}'))
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: txnHistory.data.length,
                    itemBuilder: (context, index) {
                      final txn = txnHistory.data[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            Image.asset(imgTxn, height: 30),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Owolabi M', style: st535353500Rubuk12),
                                Text('Acces bank', style: st535353400Rubik10),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(imgNaira,
                                        color: kc535353, height: 10),
                                    Text(txn.amount, style: st535353500Rubuk12),
                                  ],
                                ),
                                Text(txn.date, style: st535353400Rubik10),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
          }
        });
  }
}
