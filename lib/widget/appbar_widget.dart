import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/utilities/list_item.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/custom_button_widget.dart';
import 'package:fragvest_mobile/widget/filter_widget.dart';
import 'package:fragvest_mobile/widget/sort_by_status.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../provider/service_provider.dart';

Widget appBar({@required BuildContext context, String title}) {
  return AppBar(
    backgroundColor: kcWhite,
    elevation: 0.0,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Transform.rotate(
          angle: 3.13,
          child: Icon(
            Icons.arrow_right_alt,
            color: kc535353,
          )),
    ),
    title: Text(
      title,
      style: st535353500Rubik16,
    ),
    centerTitle: true,
  );
}

Widget customAppBar(String text, bool center) {
  return AppBar(
    backgroundColor: kcWhite,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(text,
        style: TextStyle(
            color: Color(0xFF0C0932),
            fontWeight: FontWeight.w600,
            fontSize: 18)),
    centerTitle: center,
  );
}

Widget actionAppBar(String text, String imageUrl, VoidCallback callback, bool isFilter, bool titlePosition) {
  return AppBar(
    backgroundColor: Color(0xFFFFFFFF),
    toolbarHeight: 80.0,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text(text, style: stBlue600Rubik18),
    centerTitle: titlePosition,
    actions: [
      GestureDetector(
        onTap: callback,
        child: Container(
            padding: const EdgeInsets.all(18),
            child: isFilter? Container(
              width: 97,
              // height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: Colors.red,
                  color: Color(0xFF07C168),
                  borderRadius: BorderRadius.circular(5)),
              child: Text('Clear Filter'),
            ): null
            // Image.asset(
            //   imageUrl,
            //   color: kc535353,
            //   height: 40,
            // ),
            ),
      )
    ],
  );
}

Widget propertyAppbar() {
  return AppBar(
    backgroundColor: kcWhite,
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
    title: Text(
      'Register Property',
      style: st0C0932500Rubik14,
    ),
  );
}

Widget paymentAppbar(String text) {
  return AppBar(
    backgroundColor: kc0C0932,
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: kcWhite),
    title: Text(text, style: stBlack700Rubik18.copyWith(color: kcWhite)),
  );
}

Widget ticketAppBar(BuildContext context, Widget texts) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Color(0xFFFFFFFF),
    elevation: 0,
    leadingWidth: 80,
    centerTitle: true,
    leading: GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: kcWhite, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    ),
    title: texts,
  );
}

Widget marketAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    centerTitle: true,
    backgroundColor: kcWhite,
    toolbarHeight: 80,
    title: Text('Market', style: stBlack700Rubik18),
    actions: [
      IconButton(
          icon: Container(height: 20, child: Image.asset(imgFilter)),
          onPressed: () {
            final serviceProvder =
                Provider.of<ServiceProvider>(context, listen: false);
            serviceProvder.setPriceRange(null);
            serviceProvder.setPropertyType(null);
            serviceProvder.setRooms(null);
            serviceProvder.setBedRoom(null);
            showMaterialModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  // return SortByStatus();
                  return SortDialog();
                });
          })
    ],
  );
}
