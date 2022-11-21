import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/model/get_card_model.dart';
import 'package:fragvest_mobile/utilities/styles.dart';

import '../../constants/kcolors.dart';
import '../../repository/get_services.dart';
import '../../repository/post_services.dart';
import '../../repository/repo_Validatary.dart';
import '../../widget/flush_bar_widget.dart';

class SavedCardsWidget extends StatefulWidget {
  final GetCardModel getCardModel;
  const SavedCardsWidget({Key key, this.getCardModel}) : super(key: key);

  @override
  _SavedCardsWidgetState createState() => _SavedCardsWidgetState();
}

class _SavedCardsWidgetState extends State<SavedCardsWidget> {
  bool _isCardsShowing = false;
  _showCards() {
    setState(
      () => _isCardsShowing = !_isCardsShowing,
    );
  }

  List<Data> _cards = [];

  @override
  void initState() {
    _cards.addAll(widget.getCardModel.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: _showCards,
          child: Row(
            children: [
              Transform.translate(
                  offset: Offset(-16, 0),
                  child: Text('Saved Cards', style: st535353600Rubik16)),
              Spacer(),
              Transform.translate(
                offset: Offset(16, 0),
                child: Icon(!_isCardsShowing
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up),
              ),
            ],
          ),
        ),
        if (_isCardsShowing)
          widget.getCardModel.data.length == 0
              ? Column(
                  children: [Text('No save card yet'), SizedBox(height: 20)],
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    final card = _cards[index];
                    String cardType;
                    if (('${card.cardNumber[0]}${card.cardNumber[1]}') == '51' ||
                        ('${card.cardNumber[0]}${card.cardNumber[1]}' ==
                            '52') ||
                        ('${card.cardNumber[0]}${card.cardNumber[1]}' ==
                            '53') ||
                        ('${card.cardNumber[0]}${card.cardNumber[1]}' ==
                            '54')) {
                      cardType = 'masterCard';
                    } else if (('${card.cardNumber[0]}${card.cardNumber[1]}') ==
                            '34' ||
                        ('${card.cardNumber[0]}${card.cardNumber[1]}' ==
                            '37')) {
                      cardType = 'americaExpress';
                    } else if ('${card.cardNumber[0]}' == '4') {
                      cardType = 'visa';
                    } else if (('${card.cardNumber[0]}${card.cardNumber[1]}') ==
                            '65' ||
                        ('${card.cardNumber[0]}${card.cardNumber[1]}' ==
                            '50')) {
                      cardType = 'verve';
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 40,
                                width: 60,
                                child: Image.asset(cardType == 'masterCard'
                                    ? imgMasterCard
                                    : cardType == 'visa'
                                        ? imgVisa
                                        : cardType == 'verve'
                                            ? imgVerve
                                            : imgWalletCard)),
                            SizedBox(width: 20),
                            Text(
                              card.cardNumber.replaceRange(4, 7, '*******'),
                              style: st535353300Rubik12,
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () => _deleteCardShowDialog(card, () {
                                _deleteCard(card.id, card);
                                Navigator.pop(context);
                              }),
                              icon: Transform.translate(
                                offset: Offset(10, 0),
                                child: Image.asset(
                                  imgDelete,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10)
                      ],
                    );
                  }),
      ],
    );
  }

  _deleteCard(int id, Data card) async {
    EasyLoading.show(status: 'Deleting...');
    var response = await PostServices.deleteBankCard(context, id);
    if (response is LogSucess) {
      setState(() {
        _cards.remove(card);
      });
      GetServices.getCard(context);
      EasyLoading.dismiss();
      flushbarWidget(context, response.message, false);
    } else {
      EasyLoading.dismiss();
      flushbarWidget(context, (response as LogFailure).errorMessage, false);
    }
  }

  _deleteCardShowDialog(Data card, VoidCallback callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 197,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Delete Bank Card?',
                      style: st000000400Rubik14.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    Text(
                      card.cardNumber.replaceRange(4, 7, '*******'),
                      style: st000000400Rubik14.copyWith(
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                            color: Colors.red,
                            onPressed: callback,
                            child: Text('Yes', style: stFFFFFF700Rubik18)),
                        MaterialButton(
                            color: kc3DED97,
                            onPressed: () => Navigator.pop(context),
                            child: Text('No', style: stFFFFFF700Rubik18)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
