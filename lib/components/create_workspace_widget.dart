import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'create_workspace_model.dart';
export 'create_workspace_model.dart';

class CreateWorkspaceWidget extends StatefulWidget {
  const CreateWorkspaceWidget({Key? key}) : super(key: key);

  @override
  _CreateWorkspaceWidgetState createState() => _CreateWorkspaceWidgetState();
}

class _CreateWorkspaceWidgetState extends State<CreateWorkspaceWidget> {
  late CreateWorkspaceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateWorkspaceModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().update(() {
        FFAppState().selectedMembers = [];
      });
    });

    _model.workspaceNameController ??= TextEditingController();
    _model.workspaceNameFocusNode ??= FocusNode();

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
        maxHeight: 1070,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 40,
            color: Color(0x19000000),
            offset: Offset(0, 12),
          )
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/empty-widget-ui.webp',
                    width: 160.0,
                    fit: BoxFit.contain,
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
                    size: 24.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 25, 10, 0),
              child: Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create a new workspace',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Invite new members to the workspace',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
                              child: Text(
                                'Workspace name',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      lineHeight: 1.5,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x14000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  width: 1,
                                ),
                              ),
                              child: TextFormField(
                                controller: _model.workspaceNameController,
                                focusNode: _model.workspaceNameFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.workspaceNameController',
                                  Duration(milliseconds: 100),
                                  () => setState(() {}),
                                ),
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Wallace & William',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .darkGrey2,
                                        fontSize: 15,
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
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                validator: _model
                                    .workspaceNameControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create your first chat (at least 3 members)',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 17,
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 25, 0),
                                        child: Text(
                                          'Chat name',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x14000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            width: 1,
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              _model.channelNameController,
                                          focusNode:
                                              _model.channelNameFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.channelNameController',
                                            Duration(milliseconds: 100),
                                            () => setState(() {}),
                                          ),
                                          autofocus: true,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          readOnly: FFAppState()
                                                  .selectedMembers
                                                  .length <
                                              2,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Whole team',
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .darkGrey2,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 10, 0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          maxLines: null,
                                          validator: _model
                                              .channelNameControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                child: FutureBuilder<List<UsersRecord>>(
                                  future: queryUsersRecordOnce(),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<UsersRecord> containerUsersRecordList =
                                        snapshot.data!
                                            .where(
                                                (u) => u.uid != currentUserUid)
                                            .toList();
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: Stack(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 160,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 25, 0),
                                                  child: Text(
                                                    'Chat members',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          lineHeight: 1.5,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0x14000000),
                                                        offset: Offset(0, 2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      width: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 160,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 325.0,
                                                  height: 100.0,
                                                  child: custom_widgets
                                                      .CustomMemberSelectorV2(
                                                    width: 325.0,
                                                    height: 100.0,
                                                    userDocsList:
                                                        containerUsersRecordList,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: (_model.workspaceNameController.text == null ||
                                  _model.workspaceNameController.text == '') ||
                              (_model.channelNameController.text == null ||
                                  _model.channelNameController.text == '') ||
                              (FFAppState().selectedMembers.length < 2)
                          ? null
                          : () async {
                              final firestoreBatch =
                                  FirebaseFirestore.instance.batch();
                              try {
                                FFAppState().update(() {
                                  FFAppState().addToSelectedMembers(
                                      currentUserReference!);
                                });

                                var workspacesRecordReference =
                                    WorkspacesRecord.collection.doc();
                                firestoreBatch.set(workspacesRecordReference, {
                                  ...createWorkspacesRecordData(
                                    name: _model.workspaceNameController.text,
                                    id: random_data.randomString(
                                      10,
                                      15,
                                      true,
                                      true,
                                      true,
                                    ),
                                    createdTime: getCurrentTimestamp,
                                    overview: createWorkspaceOverviewStruct(
                                      currentStatus: 'N/A',
                                      loanAmount: 0.0,
                                      communicationNotes: 'N/A',
                                      fieldValues: {
                                        'clients': (String clientOne,
                                            String clientTwo) {
                                          return [clientOne, clientTwo];
                                        }('#1', '#2'),
                                      },
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'members': FFAppState().selectedMembers,
                                    },
                                  ),
                                });
                                _model.thisWorkspace =
                                    WorkspacesRecord.getDocumentFromData({
                                  ...createWorkspacesRecordData(
                                    name: _model.workspaceNameController.text,
                                    id: random_data.randomString(
                                      10,
                                      15,
                                      true,
                                      true,
                                      true,
                                    ),
                                    createdTime: getCurrentTimestamp,
                                    overview: createWorkspaceOverviewStruct(
                                      currentStatus: 'N/A',
                                      loanAmount: 0.0,
                                      communicationNotes: 'N/A',
                                      fieldValues: {
                                        'clients': (String clientOne,
                                            String clientTwo) {
                                          return [clientOne, clientTwo];
                                        }('#1', '#2'),
                                      },
                                      clearUnsetFields: false,
                                      create: true,
                                    ),
                                  ),
                                  ...mapToFirestore(
                                    {
                                      'members': FFAppState().selectedMembers,
                                    },
                                  ),
                                }, workspacesRecordReference);
                                _model.updatePage(() {
                                  _model.thisWorkspaceRef =
                                      _model.thisWorkspace?.reference;
                                  _model.thisWorkspaceId =
                                      _model.thisWorkspace!.id;
                                });

                                firestoreBatch.update(
                                    _model.thisWorkspaceRef!,
                                    createWorkspacesRecordData(
                                      workspaceRef: _model.thisWorkspaceRef,
                                    ));
                                _model.createdGC =
                                    await FFChatManager.instance.createChat(
                                  FFAppState().selectedMembers.toList(),
                                );

                                var chatMessagesRecordReference =
                                    ChatMessagesRecord.collection.doc();
                                firestoreBatch.set(
                                    chatMessagesRecordReference,
                                    createChatMessagesRecordData(
                                      user: currentUserReference,
                                      chat: _model.createdGC?.reference,
                                      text: 'Welcome everyone!',
                                      timestamp: getCurrentTimestamp,
                                    ));
                                _model.createdChatMsg =
                                    ChatMessagesRecord.getDocumentFromData(
                                        createChatMessagesRecordData(
                                          user: currentUserReference,
                                          chat: _model.createdGC?.reference,
                                          text: 'Welcome everyone!',
                                          timestamp: getCurrentTimestamp,
                                        ),
                                        chatMessagesRecordReference);

                                firestoreBatch.update(
                                    _model.createdChatMsg!.reference,
                                    createChatMessagesRecordData(
                                      chatMessageRef:
                                          _model.createdChatMsg?.reference,
                                    ));

                                firestoreBatch.update(
                                    _model.createdGC!.reference,
                                    createChatsRecordData(
                                      chatType: 'Channel',
                                      workspaceId: _model.thisWorkspaceId,
                                      channelName:
                                          _model.channelNameController.text,
                                      workspaceRef: _model.thisWorkspaceRef,
                                      chatRef: _model.createdGC?.reference,
                                      createdTime: getCurrentTimestamp,
                                      lastMessage: _model.createdChatMsg?.text,
                                      lastMessageTime:
                                          _model.createdChatMsg?.timestamp,
                                      lastMessageSentBy:
                                          _model.createdChatMsg?.user,
                                    ));
                                FFAppState().update(() {
                                  FFAppState().selectedMembers = [];
                                });
                                Navigator.pop(context);
                              } finally {
                                await firestoreBatch.commit();
                              }

                              setState(() {});
                            },
                      text: 'Create Workplace',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56.0,
                        padding: EdgeInsets.all(0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        disabledColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
