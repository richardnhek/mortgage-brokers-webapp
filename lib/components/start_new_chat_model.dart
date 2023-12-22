import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/create_workspace_widget.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'start_new_chat_widget.dart' show StartNewChatWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartNewChatModel extends FlutterFlowModel<StartNewChatWidget> {
  ///  Local state fields for this component.

  DocumentReference? selectedWorkspaceRef;

  bool isLoaded = false;

  List<DocumentReference> selectedMemberList = [];
  void addToSelectedMemberList(DocumentReference item) =>
      selectedMemberList.add(item);
  void removeFromSelectedMemberList(DocumentReference item) =>
      selectedMemberList.remove(item);
  void removeAtIndexFromSelectedMemberList(int index) =>
      selectedMemberList.removeAt(index);
  void insertAtIndexInSelectedMemberList(int index, DocumentReference item) =>
      selectedMemberList.insert(index, item);
  void updateSelectedMemberListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      selectedMemberList[index] = updateFn(selectedMemberList[index]);

  String selectedWorkspaceId = '';

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in StartNewChat widget.
  List<WorkspacesRecord>? workspaceList;
  // State field(s) for channelName widget.
  FocusNode? channelNameFocusNode;
  TextEditingController? channelNameController;
  String? Function(BuildContext, String?)? channelNameControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  WorkspacesRecord? thisSelectedWorkspace;
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
  // Stores action output result for [Group Chat Action] action in Button widget.
  ChatsRecord? groupChatCreatedCopy;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatMessagesRecord? createdMessageCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<ChatsRecord>? chatsInWorkspaceCopy;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? createdChatCopy;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatMessagesRecord? createdMessage2Copy;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    channelNameFocusNode?.dispose();
    channelNameController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
