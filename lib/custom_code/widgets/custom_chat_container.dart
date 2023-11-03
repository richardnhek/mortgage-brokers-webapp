// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomChatContainer extends StatefulWidget {
  const CustomChatContainer(
      {Key? key, this.chatUser, this.chatRef, this.width, this.height})
      : super(key: key);

  final UsersRecord? chatUser;
  final DocumentReference? chatRef;
  final double? width;
  final double? height;

  @override
  _CustomChatContainerState createState() => _CustomChatContainerState();
}

class _CustomChatContainerState extends State<CustomChatContainer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FFChatInfo? _chatInfo;
  bool isGroupChat() {
    if (widget.chatUser == null) {
      return true;
    }
    if (widget.chatRef == null) {
      return false;
    }
    return _chatInfo?.isGroupChat ?? false;
  }

  @override
  void initState() {
    super.initState();
    FFChatManager.instance
        .getChatInfo(
      otherUserRecord: widget.chatUser,
      chatReference: widget.chatRef,
    )
        .listen((info) {
      if (mounted) {
        setState(() => _chatInfo = info);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return StreamBuilder<FFChatInfo>(
      stream: FFChatManager.instance.getChatInfo(
        otherUserRecord: widget.chatUser,
        chatReference: widget.chatRef,
      ),
      builder: (context, snapshot) => snapshot.hasData
          ? FFChatPage(
              chatInfo: snapshot.data!,
              allowImages: true,
              backgroundColor: Color(0xFFF2F4F8),
              timeDisplaySetting: TimeDisplaySetting.visibleOnTap,
              currentUserBoxDecoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              otherUsersBoxDecoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              currentUserTextStyle: GoogleFonts.getFont(
                'DM Sans',
                color: Color(0xFF1E2429),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontStyle: FontStyle.normal,
              ),
              otherUsersTextStyle: GoogleFonts.getFont(
                'DM Sans',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              inputHintTextStyle: GoogleFonts.getFont(
                'DM Sans',
                color: Color(0xFF95A1AC),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              inputTextStyle: GoogleFonts.getFont(
                'DM Sans',
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              emptyChatWidget: Image.asset(
                'assets/images/messagesEmpty@2x.png',
                width: MediaQuery.sizeOf(context).width * 0.76,
              ),
            )
          : Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
    );
  }
}
