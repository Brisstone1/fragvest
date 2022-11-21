import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/chat_model.dart';
import 'package:fragvest_mobile/provider/service_provider.dart';
import 'package:fragvest_mobile/repository/get_services.dart';
import 'package:fragvest_mobile/repository/post_services.dart';
import 'package:fragvest_mobile/repository/repo_Validatary.dart';
import 'package:fragvest_mobile/utilities/styles.dart';
import 'package:fragvest_mobile/widget/appbar_widget.dart';
import 'package:fragvest_mobile/widget/dommy_avater_widget.dart';
import 'package:fragvest_mobile/widget/flush_bar_widget.dart';
import 'package:fragvest_mobile/widget/text_input_decoration.dart';
import 'package:provider/provider.dart';

class SupportChatScreen extends StatefulWidget {
  static const routeName = '/support-chat-screen';

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final _chatController = TextEditingController();
  bool _isLoading = false;
  final ScrollController _controller = ScrollController();

  final _formKey = GlobalKey<FormState>();
  bool _isEmojiShow = false;
  // void _scrollDown() {
  //   _controller.jumpTo(_controller.position.maxScrollExtent);
  // }
  bool _firstAutoscrollExecuted = false;
  bool _shouldAutoscroll = false;

  void _scrollListener() {
    _firstAutoscrollExecuted = true;

    if (_controller.hasClients &&
        _controller.position.pixels == _controller.position.maxScrollExtent) {
      _shouldAutoscroll = true;
    } else {
      _shouldAutoscroll = false;
    }
  }

  void _scrollToBottom() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _scrollToBottom();
    ServiceProvider serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    GetServices.getChat(_controller, context, serviceProvider.ticketId);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: ticketAppBar(
            context,
            Column(children: [
              Text('Support Chat', style: st000000500Roboto14),
              Text('Online', style: st4CAF50400Roboto11)
            ])),
        body: FutureBuilder<Object>(
            future: GetServices.getChat(
                _controller, context, serviceProvider.ticketId),
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
                          setState(() {});
                        },
                        child: Text(snapshot.error.toString()),
                      )
                    ],
                  ),
                );
              } else if (!snapshot.hasData) {
                return Container(
                    height: MediaQuery.of(context).size.height,
                    // color: kc0C0932,
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator());
              } else {
                ChatModel chatModel = snapshot.data;

                return ListView(
                  // reverse: true,
                  controller: _controller,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 20,
                      width: double.infinity,
                      color: Color(0xFFF4F4F4),
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            // height: 75,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kcF2F2F2,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        chatModel.data.subject,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                          'Ticket ID: ${chatModel.data.ticketId}',
                                          style: st4CAF50400Roboto11.copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                dummyAvater()
                              ],
                            ),
                          ),
                          if (chatModel.data.agent != null)
                            Container(
                              height: 100,
                              child: Row(
                                children: [
                                  Expanded(child: Divider(color: Colors.black)),
                                  Text(
                                      '${chatModel.data.agent.firstName} ${chatModel.data.agent.lastName} Joined the chat  '),
                                  Expanded(child: Divider(color: Colors.black))
                                ],
                              ),
                            ),
                          ListView.builder(
                              // reverse: true,

                              padding: const EdgeInsets.only(bottom: 70),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: chatModel.data.chats.length,
                              // itemCount: messages.length,
                              itemBuilder: (context, index) {
                                // DummyMessageModel dummyMessageModel =
                                //     messages[index];

                                final _chat = chatModel.data.chats[index];
                                final _currentUser = _chat.sentBy;
                                bool _isMe = _currentUser == '0';
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: EdgeInsets.only(
                                      left: _isMe ? 40 : 0,
                                      right: _isMe ? 0 : 40),
                                  child: Column(
                                    crossAxisAlignment: _isMe
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: _isMe
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          // !_isMe
                                          //     ? Text(
                                          //         'Customer care Name',
                                          //         style: st4CAF50400Roboto11
                                          //             .copyWith(
                                          //                 color: Colors.black
                                          //                     .withOpacity(
                                          //                         0.5)),
                                          //       )
                                          //     : SizedBox(),
                                          Text(
                                            _chat.date,
                                            style: st4CAF50400Roboto11.copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: kcF2F2F2,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(_chat.description),
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
        bottomSheet: serviceProvider.chatStatus == 'closed'
            ? SizedBox()
            : Container(
                // margin: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 8),
                decoration: BoxDecoration(
                    color: kcF2F2F2, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              // textInputAction: TextInputAction.next,
                              controller: _chatController,
                              decoration: supportDecoration.copyWith(
                                  hintText: 'Type a message...',
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _isEmojiShow = true;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.emoji_emotions_outlined,
                                        // color: Colors.black,
                                      ))),
                              onTap: () {
                                setState(() {
                                  _isEmojiShow = false;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        _isLoading
                            ? CupertinoActivityIndicator()
                            : Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: kcF2F2F2,
                                    border: Border(
                                        left: BorderSide(color: kcC4C4C4))),
                                child:
                                    // _chatController.text.isEmpty
                                    // ? Image.asset(
                                    //     imgSend,
                                    //   )
                                    // :
                                    IconButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();

                                    _replyChat(serviceProvider.ticketId);
                                  },
                                  icon: Image.asset(
                                    imgSend,
                                  ),
                                )
                                // : CupertinoActivityIndicator()
                                )
                      ],
                    ),
                    if (_isEmojiShow)
                      Container(height: 200, child: _emojiPiker())
                  ],
                ),
              ),
      ),
    );
  }

  _replyChat(String ticketId) async {
    // Navigator.of(context).pushNamed(TicketScreen.routeName, arguments: true);
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      // EasyLoading.show();
      final response = await PostServices.replyTicket(
          context, ticketId, _chatController.text);
      setState(() {
        _chatController.clear();
        _isLoading = false;
      });
      if (response is RepoSucess) {
        setState(() {
          _isLoading = false;
          GetServices.getChat(_controller, context, ticketId);
        });
        // EasyLoading.dismiss();
      } else {
        // EasyLoading.dismiss();
        flushbarWidget(context, (response as RepoFailure).errorMessage, false);
      }
    }
  }

// 🙂
  Widget _emojiPiker() {
    return EmojiPicker(
      onEmojiSelected: (
        Category category,
        Emoji emoji,
      ) {
        _onEmojiSelected(emoji);
      },
      onBackspacePressed: _onBackspacePressed,
      config: Config(
          columns: 7,
          emojiSizeMax: 20 * (Platform.isIOS ? 1.30 : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          progressIndicatorColor: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecents: Text(
            "No Recents",
            style: TextStyle(fontSize: 20, color: Colors.black26),
          ),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL),
    );
  }

  _onEmojiSelected(Emoji emoji) {
    _chatController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _chatController.text.length));
  }

  _onBackspacePressed() {
    setState(() {
      _isEmojiShow = false;
    });
    _chatController
      ..text = _chatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _chatController.text.length));
  }
}
