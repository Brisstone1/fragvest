import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/getit.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/screens/verification_screen.dart';
import 'package:fragvest_mobile/screens/wallet/security_pin_screen.dart';
import 'package:fragvest_mobile/utilities/base_view_builder.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/viewModel/account_setting_vm.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/dommy_avater_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/random_widget.dart';
import 'package:fragvest_mobile/widget/show_custom_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'Auth_Screens/change_password.dart';

class AccountSettingScreen extends StatefulWidget {
  static const routeName = '/account-setting';

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  XFile _imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  String _imagePath;
  bool _isUploaded = false;

  _pickImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500);

    if (image != null) {
      setState(() {
        _imageFile = image;
        _imagePath = image.path;
      });
    }
    _uploadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Account Settings', true),
      body: BaseViewBuilder<AccountSettingVm>(
        model: getIt(),
        initState: (init) {
          init.getUser(context);
        },
        builder: (sVm, child) {
          return sVm.cachedUserModel == null && sVm.isUserLoadingError
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: kc3DED97,
                        onPressed: () {
                          setState(() {
                            sVm.getUser(context);
                          });
                        },
                        child: Text(sVm.userError),
                      )
                    ],
                  ),
                )
              : sVm.cachedUserModel == null
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      color: kc0C0932,
                      alignment: Alignment.center,
                      child: SpinKitFoldingCube(
                        // color: kc3DED97,
                        color: kcWhite,
                        size: 50,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 60),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                // height: 400,
                                // decoration: BoxDecoration(
                                //   color: kc0C0932,
                                //   borderRadius: BorderRadius.only(
                                //     topLeft: Radius.circular(20),
                                //     topRight: Radius.circular(20),
                                //   ),
                                // ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30),
                                    // Align(
                                    //     alignment: Alignment.center,
                                    //     child: Text(
                                    //         '${sVm.cachedUserModel.data.firstName} ${sVm.cachedUserModel.data.lastName}',
                                    //         style: stBlack700Rubik17))
                                    // ,
                                    SizedBox(height: 40),
                                    Text('Profile Information',
                                        style: TextStyle(
                                            color: kc0C0932,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    SizedBox(height: 24),
                                    boxContainerWithoutEdit(
                                        'Full Name',
                                        '${sVm.cachedUserModel.data.firstName.replaceFirst(sVm.cachedUserModel.data.firstName[0], sVm.cachedUserModel.data.firstName[0].toUpperCase())} ${sVm.cachedUserModel.data.lastName.replaceFirst(sVm.cachedUserModel.data.lastName[0], sVm.cachedUserModel.data.lastName[0].toUpperCase())} ',
                                        Icons.person,
                                        Color(0xFF0C0932),
                                        Color(0xFF07C168),
                                        () {}),
                                    boxContainerWithoutEdit(
                                        'Email',
                                        '${sVm.cachedUserModel.data.email}',
                                        Icons.mail_outline,
                                        Color(0xFF0C0932),
                                        // Color(0xFFFFFFFF),
                                        // Colors.red,
                                        Color(0xFF07C168),
                                        () {}),
                                    boxContainerWithoutEdit(
                                        'Phone Number',
                                        '${sVm.cachedUserModel.data.phone}',
                                        Icons.phone_in_talk_outlined,
                                        Color(0xFF0C0932),
                                        Color(0xFF07C168),
                                        () {}),
                                    boxContainerWithoutEdit(
                                        'Change  Password',
                                        'Tap to update password',
                                        Icons.lock_outline,
                                        Color(0xFF0C0932),
                                        Color(0xFF07C168),
                                        () => Navigator.of(context).pushNamed(
                                            ChangePassword.routeName)),
                                    SizedBox(height: 25),
                                    Text('Account Settings',
                                        style: TextStyle(
                                            color: kc0C0932,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    const SizedBox(height: 10),
                                    boxContainerWithEdit(
                                        'Verify your account',
                                        sVm.cachedUserModel.data.idUploaded ==
                                                    1 &&
                                                sVm.cachedUserModel.data
                                                        .idVerified ==
                                                    0
                                            ? 'Processing'
                                            : sVm.cachedUserModel.data
                                                        .idVerified ==
                                                    2
                                                ? 'Declined'
                                                : sVm.cachedUserModel.data
                                                            .idVerified ==
                                                        1
                                                    ? 'Verified'
                                                    : 'This will help you sell properties on our platform',
                                        Icons.check_box,
                                        Color(0xFF0C0932),
                                        Color(0xFF07C168),
                                        // sVm.cachedUserModel.data.idUploaded ==
                                        //             1 &&
                                        //         sVm.cachedUserModel.data
                                        //                 .idVerified ==
                                        //             0
                                        //     ? Color(0xFFFFFFFF)
                                        //     : sVm.cachedUserModel.data
                                        //                 .idVerified ==
                                        //             2
                                        //         ? Color(0xFFFFFFFF)
                                        //         : sVm.cachedUserModel.data
                                        //                     .idVerified ==
                                        //                 1
                                        //             ? Color(0xFFFFFFFF)
                                        //             : Colors.transparent,
                                        () {
                                      if (sVm.cachedUserModel.data.idUploaded ==
                                              0 ||
                                          sVm.cachedUserModel.data.idVerified ==
                                              2) {
                                        Navigator.of(context).pushNamed(
                                            VerificationScreen.routeName);
                                      } else {
                                        flushbarWidget(context,
                                            'Account ID Uploaded!', true);
                                      }
                                    }),
                                    boxContainerWithoutEdit(
                                        'Security Pin',
                                        '******',
                                        Icons.security,
                                        Color(0xFF0C0932),
                                        sVm.cachedUserModel.data.pin == null
                                            ? Color(0xFF07C168)
                                            : Color(0xFF07C168), () {
                                      if (sVm.cachedUserModel.data.pin ==
                                          null) {
                                        Navigator.of(context).pushNamed(
                                            SecurityPinScreen.routeName,
                                            arguments: 'set-pin');
                                      } else {
                                        flushbarWidget(context,
                                            'Security pin already set!', true);
                                      }
                                    }),
                                    GestureDetector(
                                      onTap: () {
                                        showCustomDialog(

                                            context: context,
                                            image: imgDeleteAccount,
                                            title: 'Delete Account',
                                            buttonText: 'Yes, Delete account',
                                            massage: Text(
                                              'Do you really want to delete your account and all the information in our database? Please note that you will loose all your investments and property data. This action is irreversible!',
                                              textAlign: TextAlign.center,
                                            ),
                                            callback: () {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      SecurityPinScreen
                                                          .routeName,
                                                      arguments: 'delete');
                                            },
                                            clearCalback: () {
                                              Navigator.of(context).pop();
                                            });
                                      },
                                      child: boxContainerWithoutEdit(
                                          'Delete Account',
                                          '${sVm.cachedUserModel.data.phone}',
                                          null,
                                          Color(0xFFFF725E),
                                          Color(0xFFFFFFFF), () {
                                        showCustomDialog(
                                            context: context,
                                            image: imgDeleteAccount,
                                            title: 'Delete Account',
                                            buttonText: 'Yes, Delete account',
                                            massage: Text(
                                              'Do you really want to delete your account and all the information in our database? Please note that you will loose all your investments and property data. This action is irreversible!',
                                              textAlign: TextAlign.center,
                                            ),
                                            callback: () {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      SecurityPinScreen
                                                          .routeName,
                                                      arguments: 'delete');
                                            },
                                            clearCalback: () {
                                              Navigator.of(context).pop();
                                            });
                                      }),
                                    ),
                                    SizedBox(height: 50)
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: -40,
                                  left: MediaQuery.of(context).size.width * 0.3,
                                  child: MaterialButton(
                                    onPressed: () =>
                                        showPickImageCustomDialog(context),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              // color: Colors.red,
                                              border: Border.all(
                                                color: Color(0xFF0C0932),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: _imageFile == null ||
                                                    !_isUploaded
                                                ? profileImage(sVm
                                                    .cachedUserModel
                                                    .data
                                                    .profileImg)
                                                : Image.file(
                                                    File(_imagePath),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 2,
                                            right: -10,
                                            // child: Image.asset(imgPhoto)
                                            child: CircleAvatar(
                                              radius: 16,
                                              // backgroundColor: kc3DED97,
                                              child: Image.asset(imgPhoto),
                                            ))
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }

  //   SingleChildScrollView(
  //       child: FutureBuilder<Object>(
  //           future: GetServices.getUser(context),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasError) {
  //               return Center(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     MaterialButton(
  //                       color: kc3DED97,
  //                       onPressed: () {
  //                         setState(() {});
  //                       },
  //                       child: Text(snapshot.error.toString()),
  //                     )
  //                   ],
  //                 ),
  //               );
  //             } else if (!snapshot.hasData) {
  //               return Container(
  //                 height: MediaQuery.of(context).size.height,
  //                 color: kc0C0932,
  //                 alignment: Alignment.center,
  //                 child: SpinKitFoldingCube(
  //                   // color: kc3DED97,
  //                   color: kcWhite,
  //                   size: 50,
  //                 ),
  //               );
  //             } else {
  //               UserModel userModel = snapshot.data;
  //               final _user = userModel.data;
  //               return Column(
  //                 children: [
  //                   SizedBox(height: 60),
  //                   Stack(
  //                     clipBehavior: Clip.none,
  //                     children: [
  //                       Container(
  //                         padding: const EdgeInsets.all(20),
  //                         width: double.infinity,
  //                         // height: 400,
  //                         decoration: BoxDecoration(
  //                           color: kc0C0932,
  //                           borderRadius: BorderRadius.only(
  //                             topLeft: Radius.circular(20),
  //                             topRight: Radius.circular(20),
  //                           ),
  //                         ),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             SizedBox(height: 30),
  //                             Align(
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                     '${_user.firstName} ${_user.lastName}',
  //                                     style: stFFFFFF700Rubik16)),
  //                             SizedBox(height: 40),
  //                             Text('Profile Information',
  //                                 style: stFFFFFF700Rubik16),
  //                             SizedBox(height: 24),
  //                             boxContainerWithoutEdit(
  //                                 'Name',
  //                                 '${_user.firstName} ${_user.lastName}',
  //                                 Icons.person,
  //                                 kcWhite,
  //                                 Colors.transparent,
  //                                 () {}),
  //                             boxContainerWithoutEdit(
  //                                 'Email',
  //                                 '${_user.email}',
  //                                 Icons.mail_outline,
  //                                 kcWhite,
  //                                 Colors.transparent,
  //                                 () {}),
  //                             boxContainerWithoutEdit(
  //                                 'Phone Number',
  //                                 '${_user.phone}',
  //                                 Icons.phone_in_talk_outlined,
  //                                 kcWhite,
  //                                 Colors.transparent,
  //                                 () {}),
  //                             boxContainerWithoutEdit(
  //                                 'Change  Password',
  //                                 'Tap to update password',
  //                                 Icons.lock_outline,
  //                                 kcWhite,
  //                                 Colors.transparent,
  //                                 () => Navigator.of(context)
  //                                     .pushNamed(ChangePassword.routeName)),
  //                             SizedBox(height: 50),
  //                             Text('Account Settings',
  //                                 style: stFFFFFF700Rubik16),
  //                             const SizedBox(height: 10),
  //                             boxContainerWithEdit(
  //                                 'Verify your account',
  //                                 _user.idUploaded == 1 &&
  //                                         _user.idVerified == 0
  //                                     ? 'Processing'
  //                                     : _user.idVerified == 2
  //                                         ? 'Declined'
  //                                         : _user.idVerified == 1
  //                                             ? 'Verified'
  //                                             : '(This will help you sell properties on our platform)',
  //                                 Icons.check_box_outlined,
  //                                 kcWhite,
  //                                 _user.idUploaded == 1 &&
  //                                         _user.idVerified == 0
  //                                     ? kcFFC327
  //                                     : _user.idVerified == 2
  //                                         ? Colors.red
  //                                         : _user.idVerified == 1
  //                                             ? kc3DED97
  //                                             : Colors.transparent, () {
  //                               if (_user.idUploaded == 0 ||
  //                                   _user.idVerified == 2) {
  //                                 Navigator.of(context).pushNamed(
  //                                     VerificationScreen.routeName);
  //                               } else {
  //                                 flushbarWidget(
  //                                     context, 'Account ID Uploaded!', true);
  //                               }
  //                             }),
  //                             boxContainerWithoutEdit(
  //                                 'Security Pin',
  //                                 '******',
  //                                 Icons.security,
  //                                 _user.pin == null
  //                                     ? kcWhite
  //                                     : kcWhite,
  //                                 Colors.transparent, () {
  //                               if (_user.pin == null) {
  //                                 Navigator.of(context)
  //                                     .pushNamed(SecurityPinScreen.routeName);
  //                               } else {
  //                                 flushbarWidget(context,
  //                                     'Security pin already set!', true);
  //                               }
  //                             }),
  //                             GestureDetector(
  //                               onTap: () {
  //                                 showCustomDialog(
  //                                     context: context,
  //                                     image: imgDeleteAccount,
  //                                     title: 'Delete Account',
  //                                     buttonText: 'Yes, Delete account',
  //                                     massage: Text(
  //                                       'Do you really want to delete your account and all the information in our database? Please note that you will loose all your investments and property data. This action is irreversible!',
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                                     callback: () {},
  //                                     clearCalback: () {
  //                                       Navigator.of(context).pop();
  //                                     });
  //                               },
  //                               child: Container(
  //                                 alignment: Alignment.center,
  //                                 height: 45,
  //                                 width: double.infinity,
  //                                 decoration: BoxDecoration(
  //                                     color: Color(0xFFF9F9F9),
  //                                     borderRadius: BorderRadius.circular(5)),
  //                                 child: Text(
  //                                   'Delete Account',
  //                                   style: stRed700Rubik18,
  //                                 ),
  //                               ),
  //                             ),
  //                             SizedBox(height: 50)
  //                           ],
  //                         ),
  //                       ),
  //                       Positioned(
  //                           top: -40,
  //                           left: MediaQuery.of(context).size.width * 0.37,
  //                           child: MaterialButton(
  //                             onPressed: () =>
  //                                 showPickImageCustomDialog(context),
  //                             child: Stack(
  //                               clipBehavior: Clip.none,
  //                               children: [
  //                                 Container(
  //                                   height: 70,
  //                                   width: 70,
  //                                   decoration: BoxDecoration(
  //                                       color: kcD1D1D1,
  //                                       borderRadius:
  //                                           BorderRadius.circular(40)),
  //                                   child: ClipRRect(
  //                                     borderRadius: BorderRadius.circular(40),
  //                                     // radius: 30,
  //                                     // backgroundColor: kcD1D1D1,
  //                                     child:
  //                                         _imageFile == null || !_isUploaded
  //                                             ? profileImage(_user.profileImg)
  //                                             // profileImage(
  //                                             //     serviceProvider.imageUrl)
  //                                             : Image.file(
  //                                                 File(_imagePath),
  //                                                 fit: BoxFit.cover,
  //                                               ),
  //                                   ),
  //                                 ),
  //                                 Positioned(
  //                                     bottom: 2,
  //                                     right: -20,
  //                                     child: CircleAvatar(
  //                                       radius: 16,
  //                                       backgroundColor: kc3DED97,
  //                                       child: Image.asset(imgPhoto),
  //                                     ))
  //                               ],
  //                             ),
  //                           ))
  //                     ],
  //                   ),
  //                 ],
  //               );
  //             }
  //           })),
  // );
  // }

  _uploadData() async {
    print('upload click');

    if (_imageFile != null) {
      EasyLoading.show(status: 'Uploading...');
      final resposne = await PostServices.updateProfileImage(
        context: context,
        imagePath: _imageFile,
      );
      EasyLoading.dismiss();
      if (resposne is LogSucess) {
        EasyLoading.dismiss();
        setState(() {
          GetServices.getUser(context);
          _isUploaded = true;
        });
        flushbarWidget(context, resposne.message, true);
      } else {
        EasyLoading.dismiss();
        flushbarWidget(context, (resposne as LogFailure).errorMessage, false);
      }
    }
  }

  _restImage() async {
    print('upload click');

    EasyLoading.show(status: 'Just a moment...');
    final resposne = await PostServices.resetProfileImage(
      context,
    );
    EasyLoading.dismiss();
    if (resposne is LogSucess) {
      EasyLoading.dismiss();
      // setState(() => _isUploaded = true);
      flushbarWidget(context, resposne.message, true);
    } else {
      EasyLoading.dismiss();
      flushbarWidget(context, (resposne as RepoFailure).errorMessage, false);
    }
  }

  showPickImageCustomDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 197,
              width: double.infinity,
              // margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Profile photo',
                          style: st000000400Rubik14.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _column(imgDelete, 'Remove', _restImage,
                                Color(0xFFEE2E2E)),
                            SizedBox(width: 30),
                            _column(imgImage2, 'Gallery', () {
                              _pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            }, Color(0xFF3DED97).withOpacity(0.77)

                                // _pickImage()
                                ),
                            SizedBox(width: 30),
                            _column(imgCamera, 'Camera', () {
                              _pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            }, Color(0xFF3DED97).withOpacity(0.77)),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                        right: 4,
                        top: 1,
                        child: Transform.translate(
                          offset: Offset(10, -10),
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.clear, color: kc0C0932)),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _column(
      String image, String text, VoidCallback callback, Color bgColor) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: bgColor),
            child: Image.asset(image, height: 30, fit: BoxFit.fill),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: st000000400Poppins10,
          )
        ],
      ),
    );
  }
}
