import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/channel_button_widget.dart';
import '/components/create_workspace_widget.dart';
import '/components/direct_message_button_widget.dart';
import '/components/empty_chat_widget_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/components/overview_widget.dart';
import '/components/start_new_chat_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  UsersRecord? chatUser;

  DocumentReference? chatRef;

  WorkspaceOverviewStruct? selectedOverview;
  void updateSelectedOverviewStruct(
          Function(WorkspaceOverviewStruct) updateFn) =>
      updateFn(selectedOverview ??= WorkspaceOverviewStruct());

  List<DocumentReference> workspaceMembers = [];
  void addToWorkspaceMembers(DocumentReference item) =>
      workspaceMembers.add(item);
  void removeFromWorkspaceMembers(DocumentReference item) =>
      workspaceMembers.remove(item);
  void removeAtIndexFromWorkspaceMembers(int index) =>
      workspaceMembers.removeAt(index);
  void insertAtIndexInWorkspaceMembers(int index, DocumentReference item) =>
      workspaceMembers.insert(index, item);
  void updateWorkspaceMembersAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      workspaceMembers[index] = updateFn(workspaceMembers[index]);

  List<WorkspaceFileStruct> workspaceFiles = [];
  void addToWorkspaceFiles(WorkspaceFileStruct item) =>
      workspaceFiles.add(item);
  void removeFromWorkspaceFiles(WorkspaceFileStruct item) =>
      workspaceFiles.remove(item);
  void removeAtIndexFromWorkspaceFiles(int index) =>
      workspaceFiles.removeAt(index);
  void insertAtIndexInWorkspaceFiles(int index, WorkspaceFileStruct item) =>
      workspaceFiles.insert(index, item);
  void updateWorkspaceFilesAtIndex(
          int index, Function(WorkspaceFileStruct) updateFn) =>
      workspaceFiles[index] = updateFn(workspaceFiles[index]);

  DocumentReference? workspaceRef;

  WorkspacesRecord? selectedWorkspace;

  String selectedChannel = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for MainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // Stores action output result for [Firestore Query - Query a collection] action in DirectMessageButton widget.
  UsersRecord? selectedUser;
  // Model for EmptyChatWidget component.
  late EmptyChatWidgetModel emptyChatWidgetModel1;
  // Model for Overview component.
  late OverviewModel overviewModel;
  // Model for EmptyChatWidget component.
  late EmptyChatWidgetModel emptyChatWidgetModel2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
    emptyChatWidgetModel1 = createModel(context, () => EmptyChatWidgetModel());
    overviewModel = createModel(context, () => OverviewModel());
    emptyChatWidgetModel2 = createModel(context, () => EmptyChatWidgetModel());
  }

  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
    emptyChatWidgetModel1.dispose();
    overviewModel.dispose();
    emptyChatWidgetModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
