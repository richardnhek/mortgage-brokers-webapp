import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_profiile_model.dart';
export 'user_profiile_model.dart';

class UserProfiileWidget extends StatefulWidget {
  const UserProfiileWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  final UsersRecord? userDoc;

  @override
  _UserProfiileWidgetState createState() => _UserProfiileWidgetState();
}

class _UserProfiileWidgetState extends State<UserProfiileWidget>
    with TickerProviderStateMixin {
  late UserProfiileModel _model;

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 300.ms),
        MoveEffect(
          curve: Curves.bounceOut,
          delay: 300.ms,
          duration: 400.ms,
          begin: Offset(0.0, 100.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 400.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserProfiileModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.userDoc?.photoUrl != null && widget.userDoc?.photoUrl != '') {
        setState(() {
          _model.userProfilePic = valueOrDefault<String>(
            widget.userDoc?.photoUrl,
            'https://firebasestorage.googleapis.com/v0/b/mortgage-chat-40152.appspot.com/o/content%2Fdummy-profile.webp?alt=media&token=79b4e25d-7605-43a3-81c6-1c0bde371e6f',
          );
        });
      } else {
        setState(() {
          _model.userProfilePic =
              'data:image/png;base64,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';
        });
      }
    });

    _model.fullNameController ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.userDoc?.displayName,
      'N/A',
    ));
    _model.fullNameFocusNode ??= FocusNode();

    _model.emailController ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.userDoc?.email,
      'N/A',
    ));
    _model.emailFocusNode ??= FocusNode();

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 510.0,
          maxWidth: 550.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 12.0,
              color: Color(0x1E000000),
              offset: Offset(0.0, 5.0),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25.0, 25.0, 0.0, 0.0),
              child: Text(
                'Profile',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Inter',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      lineHeight: 1.2,
                    ),
              ),
            ),
            Divider(
              height: 50.0,
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit your profile',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 17.0,
                          lineHeight: 1.2,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 15.0, 0.0),
                          child: Text(
                            'Full name',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  lineHeight: 1.5,
                                ),
                          ),
                        ),
                        Container(
                          width: 308.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x14000000),
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              width: 1.0,
                            ),
                          ),
                          child: TextFormField(
                            controller: _model.fullNameController,
                            focusNode: _model.fullNameFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.fullNameController',
                              Duration(milliseconds: 100),
                              () async {
                                setState(() {
                                  _model.isChanged = true;
                                });
                              },
                            ),
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: widget.userDoc?.displayName,
                              hintStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color:
                                        FlutterFlowTheme.of(context).darkGrey2,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: _model.fullNameControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 15.0, 0.0),
                          child: Text(
                            'Profile photo',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  lineHeight: 1.5,
                                ),
                          ),
                        ),
                        Container(
                          width: 308.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 500),
                                  fadeOutDuration: Duration(milliseconds: 500),
                                  imageUrl: _model.userProfilePic,
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/images/error_image.webp',
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      final selectedMedia =
                                          await selectMediaWithSourceBottomSheet(
                                        context: context,
                                        allowPhoto: true,
                                      );
                                      if (selectedMedia != null &&
                                          selectedMedia.every((m) =>
                                              validateFileFormat(
                                                  m.storagePath, context))) {
                                        setState(() =>
                                            _model.isDataUploading = true);
                                        var selectedUploadedFiles =
                                            <FFUploadedFile>[];

                                        var downloadUrls = <String>[];
                                        try {
                                          showUploadMessage(
                                            context,
                                            'Uploading file...',
                                            showLoading: true,
                                          );
                                          selectedUploadedFiles = selectedMedia
                                              .map((m) => FFUploadedFile(
                                                    name: m.storagePath
                                                        .split('/')
                                                        .last,
                                                    bytes: m.bytes,
                                                    height:
                                                        m.dimensions?.height,
                                                    width: m.dimensions?.width,
                                                    blurHash: m.blurHash,
                                                  ))
                                              .toList();

                                          downloadUrls = (await Future.wait(
                                            selectedMedia.map(
                                              (m) async => await uploadData(
                                                  m.storagePath, m.bytes),
                                            ),
                                          ))
                                              .where((u) => u != null)
                                              .map((u) => u!)
                                              .toList();
                                        } finally {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          _model.isDataUploading = false;
                                        }
                                        if (selectedUploadedFiles.length ==
                                                selectedMedia.length &&
                                            downloadUrls.length ==
                                                selectedMedia.length) {
                                          setState(() {
                                            _model.uploadedLocalFile =
                                                selectedUploadedFiles.first;
                                            _model.uploadedFileUrl =
                                                downloadUrls.first;
                                          });
                                          showUploadMessage(
                                              context, 'Success!');
                                        } else {
                                          setState(() {});
                                          showUploadMessage(
                                              context, 'Failed to upload data');
                                          return;
                                        }
                                      }

                                      setState(() {
                                        _model.userProfilePic =
                                            _model.uploadedFileUrl != null &&
                                                    _model.uploadedFileUrl != ''
                                                ? _model.uploadedFileUrl
                                                : widget.userDoc!.photoUrl;
                                        _model.isChanged = true;
                                      });
                                    },
                                    child: Container(
                                      width: 115.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          width: 1.0,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Upload Photo',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      setState(() {
                                        _model.userProfilePic = '';
                                      });
                                      setState(() {
                                        _model.isChanged = true;
                                      });
                                      setState(() {
                                        _model.isDataUploading = false;
                                        _model.uploadedLocalFile =
                                            FFUploadedFile(
                                                bytes: Uint8List.fromList([]));
                                        _model.uploadedFileUrl = '';
                                      });

                                      await FirebaseStorage.instance
                                          .refFromURL(_model.uploadedFileUrl)
                                          .delete();
                                    },
                                    child: Container(
                                      width: 115.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          width: 1.0,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        'Remove',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: (_model.isChanged == false)
                                ? null
                                : () async {
                                    setState(() {
                                      _model.fullNameController?.text =
                                          widget.userDoc!.displayName;
                                    });
                                    setState(() {
                                      _model.emailController?.text =
                                          _model.emailController.text;
                                    });
                                    setState(() {
                                      _model.userProfilePic =
                                          widget.userDoc!.photoUrl;
                                    });
                                    setState(() {
                                      _model.isChanged = false;
                                    });
                                  },
                            text: 'Discard changes',
                            options: FFButtonOptions(
                              height: 50.0,
                              padding: EdgeInsets.all(0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0x00FFFFFF),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).secondary4,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              disabledTextColor:
                                  FlutterFlowTheme.of(context).secondary4,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: (_model.isChanged == false)
                                ? null
                                : () async {
                                    await widget.userDoc!.reference
                                        .update(createUsersRecordData(
                                      displayName:
                                          _model.fullNameController.text,
                                      photoUrl: _model.userProfilePic,
                                    ));
                                    setState(() {
                                      _model.isChanged = false;
                                    });
                                    Navigator.pop(context);
                                  },
                            text: 'Save Changes',
                            options: FFButtonOptions(
                              height: 50.0,
                              padding: EdgeInsets.all(0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).accent1,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Color(0x49105035),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              disabledColor:
                                  FlutterFlowTheme.of(context).secondary4,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 15.0)),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 60.0,
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 17.0,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email address',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    lineHeight: 1.5,
                                  ),
                        ),
                        Container(
                          width: 308.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).darkGray1,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x14000000),
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              width: 1.0,
                            ),
                          ),
                          child: TextFormField(
                            controller: _model.emailController,
                            focusNode: _model.emailFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.emailController',
                              Duration(milliseconds: 100),
                              () async {
                                setState(() {
                                  _model.isEmailChanged = true;
                                });
                              },
                            ),
                            autofocus: true,
                            readOnly: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'alex@gmail.com',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color:
                                        FlutterFlowTheme.of(context).darkGrey2,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: _model.emailControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (false)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: (_model.isEmailChanged == false)
                                  ? null
                                  : () async {
                                      setState(() {
                                        _model.emailController?.text =
                                            widget.userDoc!.email;
                                      });
                                      setState(() {
                                        _model.isEmailChanged = false;
                                      });
                                    },
                              text: 'Discard changes',
                              options: FFButtonOptions(
                                height: 50.0,
                                padding: EdgeInsets.all(0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0x00FFFFFF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).secondary4,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                disabledTextColor:
                                    FlutterFlowTheme.of(context).secondary4,
                              ),
                            ),
                          ),
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: (_model.isEmailChanged == false)
                                  ? null
                                  : () async {
                                      await widget.userDoc!.reference
                                          .update(createUsersRecordData(
                                        email: _model.emailController.text,
                                      ));
                                      setState(() {
                                        _model.isEmailChanged = false;
                                      });
                                      Navigator.pop(context);
                                    },
                              text: 'Save Changes',
                              options: FFButtonOptions(
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).accent1,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: Color(0x49105035),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                disabledColor:
                                    FlutterFlowTheme.of(context).secondary4,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 15.0)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
    );
  }
}
