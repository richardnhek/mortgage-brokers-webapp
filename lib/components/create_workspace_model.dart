import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'create_workspace_widget.dart' show CreateWorkspaceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateWorkspaceModel extends FlutterFlowModel<CreateWorkspaceWidget> {
  ///  Local state fields for this component.

  List<String> channelMemberUidList = [];
  void addToChannelMemberUidList(String item) => channelMemberUidList.add(item);
  void removeFromChannelMemberUidList(String item) =>
      channelMemberUidList.remove(item);
  void removeAtIndexFromChannelMemberUidList(int index) =>
      channelMemberUidList.removeAt(index);
  void insertAtIndexInChannelMemberUidList(int index, String item) =>
      channelMemberUidList.insert(index, item);
  void updateChannelMemberUidListAtIndex(
          int index, Function(String) updateFn) =>
      channelMemberUidList[index] = updateFn(channelMemberUidList[index]);

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for workspaceName widget.
  FocusNode? workspaceNameFocusNode;
  TextEditingController? workspaceNameController;
  String? Function(BuildContext, String?)? workspaceNameControllerValidator;
  // State field(s) for channelName widget.
  FocusNode? channelNameFocusNode;
  TextEditingController? channelNameController;
  String? Function(BuildContext, String?)? channelNameControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<UsersRecord>? selectedMembers;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  WorkspacesRecord? createdWorkspace;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    workspaceNameFocusNode?.dispose();
    workspaceNameController?.dispose();

    channelNameFocusNode?.dispose();
    channelNameController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
