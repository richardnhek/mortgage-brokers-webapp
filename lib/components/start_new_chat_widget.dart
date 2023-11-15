import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'start_new_chat_model.dart';
export 'start_new_chat_model.dart';

class StartNewChatWidget extends StatefulWidget {
  const StartNewChatWidget({
    Key? key,
    required this.workspaceRef,
    required this.workspaceId,
    required this.memberList,
  }) : super(key: key);

  final DocumentReference? workspaceRef;
  final String? workspaceId;
  final List<DocumentReference>? memberList;

  @override
  _StartNewChatWidgetState createState() => _StartNewChatWidgetState();
}

class _StartNewChatWidgetState extends State<StartNewChatWidget> {
  late StartNewChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartNewChatModel());

    _model.channelNameController ??= TextEditingController();
    _model.channelNameFocusNode ??= FocusNode();

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

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: 590,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(25, 25, 25, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Text(
                            'Start New Chat',
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.updatePage(() {
                              FFAppState().selectedMembers = [];
                            });
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Invite new user to the chat.',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: Text(
                        'Channel name',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              lineHeight: 1.5,
                            ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x14000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        width: 1,
                      ),
                    ),
                    child: TextFormField(
                      controller: _model.channelNameController,
                      focusNode: _model.channelNameFocusNode,
                      onChanged: (_) => EasyDebounce.debounce(
                        '_model.channelNameController',
                        Duration(milliseconds: 100),
                        () => setState(() {}),
                      ),
                      autofocus: true,
                      readOnly: FFAppState().selectedMembers.length < 2,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Whole team',
                        hintStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).darkGrey2,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      ),
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                      maxLines: null,
                      validator: _model.channelNameControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.00, 0.00),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: Text(
                        'Email',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              lineHeight: 1.5,
                            ),
                      ),
                    ),
                  ),
                  StreamBuilder<List<UsersRecord>>(
                    stream: queryUsersRecord(
                      queryBuilder: (usersRecord) =>
                          usersRecord.whereIn('user_ref', widget.memberList),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      List<UsersRecord> containerUsersRecordList = snapshot
                          .data!
                          .where((u) => u.uid != currentUserUid)
                          .toList();
                      return Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).darkGrey2,
                                  width: 1,
                                ),
                              ),
                            ),
                            Container(
                              width: 540,
                              height: 100,
                              child: custom_widgets.CustomMemberSelectorV2(
                                width: 540,
                                height: 100,
                                userDocsList: containerUsersRecordList,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: FFButtonWidget(
                onPressed: (FFAppState().selectedMembers.length == 0) ||
                        ((FFAppState().selectedMembers.length > 1) &&
                            (_model.channelNameController.text == null ||
                                _model.channelNameController.text == ''))
                    ? null
                    : () async {
                        var _shouldSetState = false;
                        if (FFAppState().selectedMembers.length > 1) {
                          _model.updatePage(() {
                            FFAppState()
                                .addToSelectedMembers(currentUserReference!);
                          });

                          await ChatsRecord.collection.doc().set({
                            ...createChatsRecordData(
                              chatType: 'Channel',
                              workspaceId: '',
                              channelName: _model.channelNameController.text,
                              workspaceRef: widget.workspaceRef,
                            ),
                            ...mapToFirestore(
                              {
                                'users': FFAppState().selectedMembers,
                              },
                            ),
                          });
                        } else {
                          _model.updatePage(() {
                            FFAppState()
                                .addToSelectedMembers(currentUserReference!);
                          });
                          _model.chatsInWorkspace = await queryChatsRecordOnce(
                            queryBuilder: (chatsRecord) => chatsRecord
                                .where(
                                  'workspace_ref',
                                  isEqualTo: widget.workspaceRef,
                                )
                                .where(
                                  'users',
                                  arrayContains:
                                      FFAppState().selectedMembers.first,
                                )
                                .where(
                                  'chat_type',
                                  isEqualTo: 'DM',
                                ),
                          );
                          _shouldSetState = true;
                          if (_model.chatsInWorkspace!.length >= 1) {
                            Navigator.pop(context);
                            _model.updatePage(() {
                              FFAppState().selectedMembers = [];
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Chat already exists',
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                              ),
                            );
                            if (_shouldSetState) setState(() {});
                            return;
                          } else {
                            await ChatsRecord.collection.doc().set({
                              ...createChatsRecordData(
                                chatType: 'DM',
                                workspaceId: '',
                                channelName: _model.channelNameController.text,
                                workspaceRef: widget.workspaceRef,
                                userA: currentUserReference,
                                userB: FFAppState().selectedMembers.first,
                              ),
                              ...mapToFirestore(
                                {
                                  'users': FFAppState().selectedMembers,
                                },
                              ),
                            });
                          }
                        }

                        _model.updatePage(() {
                          FFAppState().selectedMembers = [];
                        });
                        Navigator.pop(context);
                        if (_shouldSetState) setState(() {});
                      },
                text: 'Send Invite',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 56,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        lineHeight: 1.2,
                      ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  disabledColor: FlutterFlowTheme.of(context).secondaryText,
                  hoverColor: FlutterFlowTheme.of(context).accent1,
                  hoverBorderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1,
                  ),
                  hoverTextColor: FlutterFlowTheme.of(context).primaryText,
                  hoverElevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
