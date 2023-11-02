import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/channel_button_widget.dart';
import '/components/direct_message_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'workspace_expandable_widget.dart' show WorkspaceExpandableWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkspaceExpandableModel
    extends FlutterFlowModel<WorkspaceExpandableWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Expandable widget.
  late ExpandableController expandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableController2;

  // Model for ChannelButton component.
  late ChannelButtonModel channelButtonModel1;
  // Model for ChannelButton component.
  late ChannelButtonModel channelButtonModel2;
  // Model for ChannelButton component.
  late ChannelButtonModel channelButtonModel3;
  // State field(s) for Expandable widget.
  late ExpandableController expandableController3;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    channelButtonModel1 = createModel(context, () => ChannelButtonModel());
    channelButtonModel2 = createModel(context, () => ChannelButtonModel());
    channelButtonModel3 = createModel(context, () => ChannelButtonModel());
  }

  void dispose() {
    expandableController1.dispose();
    expandableController2.dispose();
    channelButtonModel1.dispose();
    channelButtonModel2.dispose();
    channelButtonModel3.dispose();
    expandableController3.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
