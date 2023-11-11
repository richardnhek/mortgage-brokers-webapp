import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'overview_widget.dart' show OverviewWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OverviewModel extends FlutterFlowModel<OverviewWidget> {
  ///  Local state fields for this component.

  bool isChanged = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for current_status widget.
  FocusNode? currentStatusFocusNode;
  TextEditingController? currentStatusController;
  String? Function(BuildContext, String?)? currentStatusControllerValidator;
  // State field(s) for loan_amount widget.
  FocusNode? loanAmountFocusNode;
  TextEditingController? loanAmountController;
  String? Function(BuildContext, String?)? loanAmountControllerValidator;
  // State field(s) for communication_notes widget.
  FocusNode? communicationNotesFocusNode;
  TextEditingController? communicationNotesController;
  String? Function(BuildContext, String?)?
      communicationNotesControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  WorkspacesRecord? currentWorkspace;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    currentStatusFocusNode?.dispose();
    currentStatusController?.dispose();

    loanAmountFocusNode?.dispose();
    loanAmountController?.dispose();

    communicationNotesFocusNode?.dispose();
    communicationNotesController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
