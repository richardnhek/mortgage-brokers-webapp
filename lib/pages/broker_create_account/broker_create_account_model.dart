import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'broker_create_account_widget.dart' show BrokerCreateAccountWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class BrokerCreateAccountModel
    extends FlutterFlowModel<BrokerCreateAccountWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameController;
  String? Function(BuildContext, String?)? nameControllerValidator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberController;
  final phoneNumberMask = MaskTextInputFormatter(mask: '+61 (###) ###-###');
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;
  // State field(s) for phoneNumberExist widget.
  FocusNode? phoneNumberExistFocusNode;
  TextEditingController? phoneNumberExistController;
  final phoneNumberExistMask =
      MaskTextInputFormatter(mask: '+61 (###) ###-###');
  String? Function(BuildContext, String?)? phoneNumberExistControllerValidator;
  // State field(s) for companyName widget.
  FocusNode? companyNameFocusNode;
  TextEditingController? companyNameController;
  String? Function(BuildContext, String?)? companyNameControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    nameFocusNode?.dispose();
    nameController?.dispose();

    emailFocusNode?.dispose();
    emailController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberController?.dispose();

    phoneNumberExistFocusNode?.dispose();
    phoneNumberExistController?.dispose();

    companyNameFocusNode?.dispose();
    companyNameController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
