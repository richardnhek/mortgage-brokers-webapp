import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/channel_button_widget.dart';
import '/components/direct_message_button_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  UsersRecord? chatUser;

  DocumentReference? chatRef;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for MainWebNav component.
  late MainWebNavModel mainWebNavModel;
  // State field(s) for Expandable widget.
  late ExpandableController expandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableController2;

  // State field(s) for Expandable widget.
  late ExpandableController expandableController3;

  // State field(s) for Expandable widget.
  late ExpandableController expandableController4;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    mainWebNavModel = createModel(context, () => MainWebNavModel());
  }

  void dispose() {
    unfocusNode.dispose();
    mainWebNavModel.dispose();
    expandableController1.dispose();
    expandableController2.dispose();
    expandableController3.dispose();
    expandableController4.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
