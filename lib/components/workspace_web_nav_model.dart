import '/components/workspace_expandable_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'workspace_web_nav_widget.dart' show WorkspaceWebNavWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkspaceWebNavModel extends FlutterFlowModel<WorkspaceWebNavWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for WorkspaceExpandable component.
  late WorkspaceExpandableModel workspaceExpandableModel;
  // State field(s) for Expandable widget.
  late ExpandableController expandableController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    workspaceExpandableModel =
        createModel(context, () => WorkspaceExpandableModel());
  }

  void dispose() {
    workspaceExpandableModel.dispose();
    expandableController.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
