import 'index.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:transparent_image/transparent_image.dart';

enum TimeDisplaySetting {
  alwaysVisible,
  alwaysInvisible,
  visibleOnTap,
}

class FFChatWidget extends StatelessWidget {
  const FFChatWidget({
    Key? key,
    required this.currentUser,
    required this.scrollController,
    required this.focusNode,
    required this.messages,
    required this.onSend,
    this.uploadMediaAction,
    // Theme settings
    this.backgroundColor,
    this.timeDisplaySetting = TimeDisplaySetting.visibleOnTap,
    this.currentUserBoxDecoration,
    this.otherUsersBoxDecoration,
    this.currentUserTextStyle,
    this.otherUsersTextStyle,
    this.inputHintTextStyle,
    this.inputTextStyle,
    this.emptyChatWidget,
  }) : super(key: key);

  final ChatUser currentUser;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final List<ChatMessage> messages;
  final Function(ChatMessage) onSend;
  final Function()? uploadMediaAction;

  final Color? backgroundColor;
  final TimeDisplaySetting? timeDisplaySetting;
  final BoxDecoration? currentUserBoxDecoration;
  final BoxDecoration? otherUsersBoxDecoration;
  final TextStyle? currentUserTextStyle;
  final TextStyle? otherUsersTextStyle;
  final TextStyle? inputHintTextStyle;
  final TextStyle? inputTextStyle;
  final Widget? emptyChatWidget;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: focusNode.unfocus,
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Theme(
                  data: ThemeData(brightness: Brightness.light),
                  child: DashChat(
                    scrollController: scrollController,
                    focusNode: focusNode,
                    shouldShowLoadEarlier: false,
                    scrollToBottom: false,
                    inverted: true,
                    inputMaxLines: 10,
                    user: currentUser,
                    messages: messages.reversed.toList(),
                    onLoadEarlier: () => {},
                    onSend: onSend,
                    leading: const [SizedBox(width: 10.0)],
                    trailing: [
                      if (uploadMediaAction != null)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 12.0, end: 6.0),
                          child: InkWell(
                            onTap: uploadMediaAction,
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xA1A1A1A1),
                              size: 24,
                            ),
                          ),
                        ),
                    ],
                    inputDecoration: InputDecoration.collapsed(
                      hintText: 'Type message here',
                      hintStyle: inputHintTextStyle ??
                          GoogleFonts.getFont(
                            'Inter',
                            color: const Color(0xFF95A1AC),
                            fontSize: 14,
                          ),
                      fillColor: Colors.white,
                    ),
                    inputTextStyle: inputTextStyle ??
                        GoogleFonts.getFont(
                          'Inter',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                    inputToolbarMargin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                    ),
                    inputToolbarPadding:
                        const EdgeInsets.symmetric(vertical: 6.0),
                    messageContainerPadding:
                        const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 0.0),
                    inputContainerStyle: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    showUserAvatar: true,
                    avatarBuilder: (p0) =>
                        p0.avatar != null && p0.avatar!.length != 0
                            ? Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: p0.avatar!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Center(
                                    child: Text(
                                  p0.name == null || p0.name!.isEmpty
                                      ? ''
                                      : p0.name![0],
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                )),
                              ),
                    messageBuilder: (chatMessage) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row for user name and timestamp
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  chatMessage.user.name!,
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  chatMessage.createdAt.isBefore(DateTime.now()
                                          .subtract(const Duration(minutes: 3)))
                                      ? timeago.format(chatMessage.createdAt)
                                      : DateFormat.jm()
                                          .format(chatMessage.createdAt),
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            // Message text
                            Text(
                              chatMessage.text!,
                              style: GoogleFonts.getFont(
                                'Inter',
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (messages.isEmpty && emptyChatWidget != null)
                Center(child: emptyChatWidget),
            ],
          ),
        ),
      );
}

class FFChatMessage extends StatefulWidget {
  const FFChatMessage({
    Key? key,
    required this.chatMessage,
    required this.isMe,
    this.currentUserBoxDecoration,
    this.otherUsersBoxDecoration,
    this.timeDisplaySetting,
    this.currentUserTextStyle,
    this.otherUsersTextStyle,
  }) : super(key: key);

  final ChatMessage chatMessage;
  final TimeDisplaySetting? timeDisplaySetting;
  final BoxDecoration? currentUserBoxDecoration;
  final BoxDecoration? otherUsersBoxDecoration;
  final TextStyle? currentUserTextStyle;
  final TextStyle? otherUsersTextStyle;
  final bool isMe;

  @override
  _FFChatMessageState createState() => _FFChatMessageState();
}

class _FFChatMessageState extends State<FFChatMessage> {
  bool _showTime = false;
  bool get showTime {
    switch (widget.timeDisplaySetting) {
      case TimeDisplaySetting.alwaysVisible:
        return true;
      case TimeDisplaySetting.alwaysInvisible:
        return false;
      case TimeDisplaySetting.visibleOnTap:
      default:
        return _showTime;
    }
  }

  TextStyle get textStyle => (GoogleFonts.getFont(
        'Inter',
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      )).copyWith(height: 1.5);

  bool get hasImage => (widget.chatMessage.image ?? '').isNotEmpty;

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => setState(() => _showTime = !showTime),
              splashColor: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65),
                child: hasImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: widget.chatMessage.image!,
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        child: Text(
                          widget.chatMessage.text!,
                          style: textStyle,
                        ),
                      ),
              ),
            ),
            if (showTime)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 2.0),
                child: Text(
                  widget.chatMessage.createdAt.isBefore(
                          DateTime.now().subtract(const Duration(minutes: 3)))
                      ? timeago.format(widget.chatMessage.createdAt)
                      : DateFormat.jm().format(widget.chatMessage.createdAt),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      );
}
