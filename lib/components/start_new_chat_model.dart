import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'start_new_chat_widget.dart' show StartNewChatWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartNewChatModel extends FlutterFlowModel<StartNewChatWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for channelName widget.
  FocusNode? channelNameFocusNode;
  TextEditingController? channelNameController;
  String? Function(BuildContext, String?)? channelNameControllerValidator;
  // Stores action output result for [Group Chat Action] action in Button widget.
  ChatsRecord? groupChatCreated;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatMessagesRecord? createdMessage;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<ChatsRecord>? chatsInWorkspace;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? createdChat;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatMessagesRecord? createdMessage2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    channelNameFocusNode?.dispose();
    channelNameController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
