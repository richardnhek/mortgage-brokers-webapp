import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'code_verification_model.dart';
export 'code_verification_model.dart';

class CodeVerificationWidget extends StatefulWidget {
  const CodeVerificationWidget({
    Key? key,
    required this.phoneNumber,
    this.userEmail,
    this.displayName,
    String? authType,
    this.companyName,
  })  : this.authType = authType ?? '',
        super(key: key);

  final String? phoneNumber;
  final String? userEmail;
  final String? displayName;
  final String authType;
  final String? companyName;

  @override
  _CodeVerificationWidgetState createState() => _CodeVerificationWidgetState();
}

class _CodeVerificationWidgetState extends State<CodeVerificationWidget> {
  late CodeVerificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CodeVerificationModel());

    authManager.handlePhoneAuthStateChanges(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

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

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.825,
              constraints: BoxConstraints(
                maxWidth: 440.0,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.asset(
                        'assets/images/logo.jpeg',
                        height: 50.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'We sent you a code to verify your mobile phone',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Text(
                              widget.phoneNumber!,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 75.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: Text(
                                    'Secure code',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 0.0),
                                  child: PinCodeTextField(
                                    autoDisposeControllers: false,
                                    appContext: context,
                                    length: 6,
                                    textStyle:
                                        FlutterFlowTheme.of(context).bodyLarge,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    enableActiveFill: false,
                                    autoFocus: true,
                                    enablePinAutofill: false,
                                    errorTextSpace: 0.0,
                                    showCursor: true,
                                    cursorColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    obscureText: false,
                                    hintCharacter: '*',
                                    keyboardType: TextInputType.number,
                                    pinTheme: PinTheme(
                                      fieldHeight: 60.0,
                                      fieldWidth: 60.0,
                                      borderWidth: 1.0,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0),
                                      ),
                                      shape: PinCodeFieldShape.box,
                                      activeColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      inactiveColor:
                                          FlutterFlowTheme.of(context)
                                              .alternate,
                                      selectedColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                      activeFillColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      inactiveFillColor:
                                          FlutterFlowTheme.of(context)
                                              .alternate,
                                      selectedFillColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                    controller: _model.pinCodeController,
                                    onChanged: (_) async {
                                      setState(() {
                                        _model.isComplete = false;
                                      });
                                    },
                                    onCompleted: (_) async {
                                      setState(() {
                                        _model.isComplete = true;
                                      });
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: _model.pinCodeControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      if (_model.isSent == false) {
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            setState(() {
                                              _model.isSent = true;
                                            });
                                            _model.timerController
                                                .onStartTimer();
                                            final phoneNumberVal =
                                                '+${widget.phoneNumber}';
                                            if (phoneNumberVal == null ||
                                                phoneNumberVal.isEmpty ||
                                                !phoneNumberVal
                                                    .startsWith('+')) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Phone Number is required and has to start with +.'),
                                                ),
                                              );
                                              return;
                                            }
                                            await authManager.beginPhoneAuth(
                                              context: context,
                                              phoneNumber: phoneNumberVal,
                                              onCodeSent: (context) async {
                                                context.goNamedAuth(
                                                  'CodeVerification',
                                                  context.mounted,
                                                  queryParameters: {
                                                    'phoneNumber':
                                                        serializeParam(
                                                      widget.phoneNumber,
                                                      ParamType.String,
                                                    ),
                                                    'authType': serializeParam(
                                                      widget.authType,
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                  ignoreRedirect: true,
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'Resend Code',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                          ),
                                        );
                                      } else {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FlutterFlowTimer(
                                              initialTime:
                                                  _model.timerMilliseconds,
                                              getDisplayTime: (value) =>
                                                  StopWatchTimer.getDisplayTime(
                                                value,
                                                hours: false,
                                                milliSecond: false,
                                              ),
                                              controller:
                                                  _model.timerController,
                                              updateStateInterval:
                                                  Duration(milliseconds: 1000),
                                              onChanged: (value, displayTime,
                                                  shouldUpdate) {
                                                _model.timerMilliseconds =
                                                    value;
                                                _model.timerValue = displayTime;
                                                if (shouldUpdate)
                                                  setState(() {});
                                              },
                                              onEnded: () async {
                                                setState(() {
                                                  _model.isSent = false;
                                                });
                                                _model.timerController
                                                    .onResetTimer();
                                              },
                                              textAlign: TextAlign.start,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 12.0,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(1.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                's',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 100.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: _model.isComplete == false
                                  ? null
                                  : () async {
                                      final firestoreBatch =
                                          FirebaseFirestore.instance.batch();
                                      try {
                                        GoRouter.of(context).prepareAuthEvent();
                                        final smsCodeVal =
                                            _model.pinCodeController!.text;
                                        if (smsCodeVal == null ||
                                            smsCodeVal.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Enter SMS verification code.'),
                                            ),
                                          );
                                          return;
                                        }
                                        final phoneVerifiedUser =
                                            await authManager.verifySmsCode(
                                          context: context,
                                          smsCode: smsCodeVal,
                                        );
                                        if (phoneVerifiedUser == null) {
                                          return;
                                        }

                                        if (widget.authType == 'Create') {
                                          firestoreBatch.update(
                                              currentUserReference!,
                                              createUsersRecordData(
                                                email: widget.userEmail,
                                                displayName: widget.displayName,
                                                userRef: currentUserReference,
                                                photoUrl:
                                                    'https://cdn.iconscout.com/icon/free/png-256/free-profile-1481935-1254808.png',
                                                userType: 'Broker',
                                                company: widget.companyName,
                                              ));
                                        } else if (widget.authType ==
                                            'Create-Client') {
                                          firestoreBatch.update(
                                              currentUserReference!,
                                              createUsersRecordData(
                                                email: widget.userEmail,
                                                displayName: widget.displayName,
                                                userRef: currentUserReference,
                                                photoUrl:
                                                    'https://cdn.iconscout.com/icon/free/png-256/free-profile-1481935-1254808.png',
                                                userType: 'Client',
                                                company: widget.companyName,
                                              ));
                                          GoRouter.of(context)
                                              .prepareAuthEvent();
                                          await authManager.signOut();
                                          GoRouter.of(context)
                                              .clearRedirectLocation();

                                          context.goNamedAuth(
                                            'SuccessfulRegistration',
                                            context.mounted,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        }
                                      } finally {
                                        await firestoreBatch.commit();
                                      }
                                    },
                              text: 'Confirm',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      lineHeight: 1.5,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                disabledColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 25.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.safePop();
                              },
                              text: 'Back',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Colors.transparent,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      fontSize: 16.0,
                                      lineHeight: 1.5,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                hoverColor:
                                    FlutterFlowTheme.of(context).accent1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
